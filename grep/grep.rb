=begin
Write your code for the 'Grep' exercise in this file. Make the tests in
`grep_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/grep` directory.
=end

module Grep
  module_function

  def grep(pattern, flags, files)
    regex = Regexp.new(pattern)
    files = files.map { |file| File.new(file) }

    Options.for(flags).each do |option|
      regex = option.parse_regex(regex)
    end

    matches = files.flat_map do |file|
      file.grep(regex)
    end

    if flags.include?('-v')
      matches = files.flat_map do |file|
        file.details - matches
      end
    end

    if flags.include?('-l')
      Options::PrintNameOption.new.print(matches).first
    elsif flags.include?('-n')
      Options::PrintLineOption.new.print(matches).join("\n")
    else
      matches.map(&:line).join("\n")
    end

  end

  class Options
    def self.for(flags)
      flags.map do |flag|
        case flag
        when '-i'
          CaseInsensitiveOption.new
        when '-x'
          FullMatchOption.new
        when '-l'
          PrintNameOption.new
        when '-n'
          PrintLineOption.new
        when '-v'
          InvertedMatchesOption.new
        else
          raise 'unknown flag'
        end
      end
    end

    class Option
      def parse_regex(regex)
        regex
      end

      def print(matches)
        matches.map(&:line)
      end
    end

    class CaseInsensitiveOption < Option
      def parse_regex(regex)
        options = regex.options + Regexp::IGNORECASE
        Regexp.new(regex.source, options)
      end
    end

    class PrintNameOption < Option
      def print(matches)
        matches.map(&:filename)
      end
    end

    class FullMatchOption < Option
      def parse_regex(regex)
        Regexp.new(/^#{regex.to_s}$/)
      end
    end

    class PrintLineOption < Option
      def print(matches)
        matches.map do |match|
          "#{match.number}:#{match.line}"
        end
      end
    end

    class InvertedMatchesOption < Option
    end
  end

  class File
    Detail = Struct.new(:line, :number, :filename, keyword_init: true)

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

