require_relative 'lib/options'
require_relative 'lib/file'
require_relative 'lib/output'

module Grep
  module_function

  def grep(pattern, flags, files)
    files   = files.map { |file| File.new(file) }
    options = Options.new(flags, files)
    Output.print(matches: matches(lines_for(files), options, pattern), options: options)
  end

  def matches(lines, options, pattern)
    match(lines,
          regex: options.regex_for(pattern),
          inverted: options.inverted?)
  end

  def match(file_lines, regex:, inverted: false)
    matched, unmatched = file_lines.partition { |file_line| file_line.match(regex) }

    inverted ? unmatched : matched
  end

  def lines_for(files)
    files.flat_map(&:lines)
  end
end
