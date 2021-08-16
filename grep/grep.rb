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

    Options.for(flags).each do |option|
      regex = option.parse_regex(regex)
    end

    files = files.map { |file| File.new(file) }

    results = files.select do |file|
      file.grep(regex)
    end

    if flags.include?('-l')
      Options::PrintNameOption.new.print(results).first
    else
      results.first.grep(regex).first
    end

  end

  class Options
    def self.for(flags)
      flags.map do |flag|
        case flag
        when '-i'
          CaseInsensitiveOption.new
        when '-l'
          PrintNameOption.new
        else
          raise 'unknown flag'
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
        Regexp.new(regex.source, Regexp::IGNORECASE)
      end
    end

    class PrintNameOption < Option
      def print(files)
        files.map(&:path)
      end
    end
  end

  class File
    attr_reader :lines, :path
    def initialize(path)
      @path = path
      @lines = ::File.read(path).split("\n")
    end

    def grep(pattern)
      lines.select { |line| pattern =~ line }
    end
  end
end

