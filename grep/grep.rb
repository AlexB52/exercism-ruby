=begin
Write your code for the 'Grep' exercise in this file. Make the tests in
`grep_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/grep` directory.
=end

module Grep
  module_function

  Detail = Struct.new(:line, :number, :filename, keyword_init: true) do
    def print
      line
    end

    def print_with_filename
      "#{filename}:#{line}"
    end

    def print_with_line_number
      "#{number}:#{line}"
    end

    def print_with_filename_and_line_number
      "#{filename}:#{number}:#{line}"
    end
  end

  def grep(pattern, flags, files)
    regex = Regexp.new(pattern)
    files = files.map { |file| File.new(file) }
    file_count = files.length

    Options.for(flags).each do |option|
      regex = option.parse_regex(regex)
    end

    details = files.flat_map(&:details)

    matches = files.flat_map do |file|
      file.grep(regex)
    end

    if flags.include?('-v')
      matches = details - matches
    end

    if flags.include?('-l')
      matches.map(&:filename)
    elsif flags.include?('-n')
      if files.length > 1
        matches.map(&:print_with_filename_and_line_number)
      else
        matches.map(&:print_with_line_number)
      end
    else
      if files.length > 1
        matches.map(&:print_with_filename)
      else
        matches.map(&:print)
      end
    end.join("\n")
  end

  class Options
    def self.for(flags)
      flags.map do |flag|
        case flag
        when '-i'
          CaseInsensitiveOption.new
        when '-x'
          FullMatchOption.new
        else
          Option.new
        end
      end
    end

    class Option
      def parse_regex(regex)
        regex
      end
    end

    class CaseInsensitiveOption < Option
      def parse_regex(regex)
        options = regex.options + Regexp::IGNORECASE
        Regexp.new(regex.source, options)
      end
    end

    class FullMatchOption < Option
      def parse_regex(regex)
        Regexp.new(/^#{regex.to_s}$/)
      end
    end
  end

  class File
    attr_reader :lines, :path, :matches
    def initialize(path)
      @path = path
      @lines = ::File.read(path).split("\n")
    end

    def details
      @lines.map.with_index do |line, index|
        Detail.new(line: line, number: (index + 1), filename: path)
      end
    end

    def grep(pattern)
      lines.filter_map.with_index do |line, index|
        if pattern =~ line
          Detail.new(line: line, number: (index + 1), filename: path)
        end
      end
    end
  end
end

