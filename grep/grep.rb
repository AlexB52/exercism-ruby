require_relative 'lib/options'
require_relative 'lib/file'
require_relative 'lib/output'

module Grep
  module_function

  def grep(pattern, flags, files)
    options = Options.new(flags, files)
    matches = matches(files, regex: options.regex_for(pattern), inverted: options.inverted?)

    Output.print(matches) do |output|
      output.add_number    = options.line_number?
      output.add_filename  = options.filename?
      output.filename_only = options.filenames_only?
    end
  end

  def matches(files, regex:, inverted: false)
    matched, unmatched = lines_for(files).partition { |file_line| file_line.match(regex) }

    inverted ? unmatched : matched
  end

  def lines_for(files)
    files.flat_map { |file| File.new(file).lines }
  end
end
