#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
DOCS = Dir.glob("#{ROOT}/**/*.md")

DOCS.each do |path|
  content = File.read(path)

  # Grab frontmatter
  frontmatter = content[/\A---\n.*?\n---/m]
  next unless frontmatter
  meta = YAML.safe_load(frontmatter)
  next unless meta["type"] == "protocol"

  title = meta["title"]
  heading = content[/^# (.+)$/, 1]

  puts "#{path}:"
  puts "  title   = #{title.inspect}"
  puts "  heading = #{heading.inspect}"

  # Detect commands (## or ### sections, uppercase only)
  commands = content.scan(/^##+\s+([A-Z0-9 ]+)$/).map do |m|
    # Normalize spaces to underscores
    m.first.strip.gsub(/\s+/, "_")
  end

  # Omit commands that start with a number (e.g., 404, 422)
  commands.reject! { |cmd| cmd =~ /^\d/ }

  if commands.any?
    puts "  commands:"
    commands.each do |cmd|
      puts "    - #{cmd}"
    end
  else
    puts "  commands: (none found)"
  end

  puts
end