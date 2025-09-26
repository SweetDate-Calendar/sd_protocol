#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"

ROOT = File.expand_path("..", __dir__)
DOCS = Dir.glob("#{ROOT}/**/*.md")

DOCS.each do |path|
  content = File.read(path)

  # Grab frontmatter
  frontmatter = content[/\A---\n.*?\n---/m]
  next unless frontmatter   # skip files with no frontmatter

  meta = YAML.safe_load(frontmatter)
  next unless meta["type"] == "protocol"   # ✅ only process protocol docs

  title = meta["title"]

  # Grab first top-level heading
  heading = content[/^# (.+)$/, 1]

  puts "#{path}:"
  puts "  title   = #{title.inspect}"
  puts "  heading = #{heading.inspect}"
  puts
end