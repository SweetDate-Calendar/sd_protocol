#!/usr/bin/env ruby
# frozen_string_literal: true
require "yaml"
require "json"

DOCS_DIR = File.expand_path("..", __dir__)
ERRORS = []

def read_frontmatter(path)
  text = File.read(path)
  return {} unless text.start_with?("---")

  fm_text = text.split(/^---\s*$/)[1]
  return {} unless fm_text

  YAML.safe_load(fm_text) || {}
rescue
  {}
end

def check_file(path, errors)
  content = File.read(path)

  frontmatter = read_frontmatter(path)
  return unless frontmatter["type"] == "protocol"

  lines = content.lines
  title = frontmatter["title"]

  first_heading = lines.find { |l| l.start_with?("# ") }
  if first_heading.nil?
    errors << "#{path}: Missing top-level heading"
  elsif first_heading.strip != "# #{title}"
    errors << "#{path}: First heading does not match frontmatter title"
  end

  %w[Request Response].each do |section|
    unless content.match?(/^\*\*#{section}\*\*/)
      errors << "#{path}: Missing section '#{section}'"
    end
  end

  check_language_tag(content, path, errors)
  validate_json_blocks(content, path, errors)
end

def check_language_tag(content, path, errors)
  in_code = false
  open_lang = nil
  first_code_line = nil
  line_num = 0

  content.each_line do |line|
    line_num += 1

    if !in_code
      if line =~ /^\s*```([^\s`]*)\s*$/
        in_code = true
        open_lang = ($1 || "").strip
        first_code_line = nil
        open_line_num = line_num
      end
    else
      stripped = line.strip
      first_code_line ||= stripped unless stripped.empty?

      if line =~ /^\s*```\s*$/
        if open_lang.nil? || open_lang.empty?
          allow_http = first_code_line && first_code_line.match?(/^(GET|POST|PUT|DELETE)\s/i)
          allow_json = first_code_line && (first_code_line.start_with?("{") || first_code_line.start_with?("["))

          unless allow_http || allow_json
            errors << "#{path}: Found code block without language tag (opened at line #{open_line_num})"
          end
        end

        in_code = false
        open_lang = nil
        first_code_line = nil
      end
    end
  end
end

def validate_json_blocks(content, path, errors)
  line_num = 0
  in_json = false
  buffer = nil
  start_line = nil

  content.each_line do |line|
    line_num += 1

    if !in_json && line =~ /^\s*```json\s*$/
      in_json = true
      buffer = String.new   # ✅ mutable string
      start_line = line_num
    elsif in_json && line =~ /^\s*```\s*$/
      begin
        JSON.parse(buffer.strip)
      rescue JSON::ParserError => e
        errors << "#{path}: Invalid JSON block starting at line #{start_line} — #{e.message}"
      end
      in_json = false
      buffer = nil
    elsif in_json
      buffer << line
    end
  end
end

Dir.glob(File.join(DOCS_DIR, "**/*.md")).each do |file|
  check_file(file, ERRORS)
end

if ERRORS.any?
  puts "❌ Consistency check failed:"
  ERRORS.each { |e| puts "  - #{e}" }
  exit 1
else
  puts "✅ All checks passed"
end