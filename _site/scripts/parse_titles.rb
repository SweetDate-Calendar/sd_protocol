#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"
require "json"

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

  # Detect commands
  commands = content.scan(/^##+\s+([A-Z][A-Z0-9_ ]*)$/)
  commands.reject! { |cmd| cmd.first =~ /^\d/ }

  if commands.any?
    puts "  commands:"
    commands.each do |cmd|
      name = cmd.first.strip
      puts "    - #{name}"

      # Slice content for this command until the next ###
      section_pattern = /^##+\s+#{Regexp.escape(name)}.*?(?=^##+|\z)/m
      section = content[section_pattern]

      if section
        # Extract **Request** block
        request_block = section[/\*\*Request\*\*.*?```(.*?)```/m, 1]
        request_block&.strip!
        puts "      request: #{request_block.inspect}" if request_block

        # Extract **Response** block
        response_block = section[/\*\*Response\*\*.*?```json\s*(.*?)```/m, 1]
        if response_block
          begin
            json = JSON.parse(response_block)
            puts "      response: #{JSON.pretty_generate(json).gsub("\n", "\n        ")}"
          rescue JSON::ParserError
            puts "      response: INVALID JSON"
          end
        end
      end
    end
  else
    puts "  commands: (none found)"
  end

  puts
end