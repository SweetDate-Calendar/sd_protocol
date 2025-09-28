#!/usr/bin/env ruby
# frozen_string_literal: true

require "yaml"
require "json"

ROOT = File.expand_path("..", __dir__)
DOCS = Dir.glob("#{ROOT}/**/*.md")

def extract_frontmatter(content)
  frontmatter = content[/\A---\n.*?\n---/m]
  return {} unless frontmatter
  YAML.safe_load(frontmatter) || {}
end

def extract_commands(content)
  commands = []
  current = nil
  in_request = false
  in_response = false
  buffer = []

  content.each_line do |line|
    if line =~ /^###\s+([A-Z0-9_ ]+)$/
      # save previous
      if current
        if in_response
          current[:response] = split_response(buffer.join.strip)
        elsif in_request
          current[:request] = buffer.join.strip
        end
        commands << current
      end
      current = { name: $1.strip.gsub(" ", "_"), request: nil, response: nil }
      in_request = false
      in_response = false
      buffer = []
    elsif line.strip == "**Request**"
      in_request = true
      in_response = false
      buffer = []
    elsif line.strip == "**Response**"
      if in_request && current
        current[:request] = buffer.join.strip
      end
      in_request = false
      in_response = true
      buffer = []
    elsif line =~ /^---$/ && (in_request || in_response)
      # ignore dividers
    elsif line =~ /^\s*```/
      # ignore code block markers
    else
      buffer << line if in_request || in_response
    end
  end

  # flush last
  if current
    if in_response
      current[:response] = split_response(buffer.join.strip)
    elsif in_request
      current[:request] = buffer.join.strip
    end
    commands << current
  end

  commands
end

def split_response(text)
  return nil if text.nil? || text.empty?

  parts = text.split(/\*\*Error\*\*/i).map(&:strip)
  if parts.size > 1
    {
      "ok" => parts.first,
      "error" => parts[1..].join("\n\n").strip
    }
  else
    { "ok" => text }
  end
end

DOCS.each do |path|
  content = File.read(path)
  meta = extract_frontmatter(content)
  next unless meta["type"] == "protocol"

  heading = content[/^# (.+)$/, 1]
  key = heading.upcase.gsub(" ", "_")

  json = {
    key => {
      "commands" => extract_commands(content)
    }
  }
  puts path

  puts JSON.pretty_generate(json)
  break  # only show first file for now
end