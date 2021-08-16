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
      regex = option.parse(regex)
    end

    files.flat_map do |file|
      File.new(file).grep(regex)
    end.first
  end

  class Options
    def self.for(flags)
      flags.map do |flag|
        case flag
        when '-i'
          CaseInsensitiveOption.new
        else
          raise 'unknown flag'
        end
      end
    end

    class CaseInsensitiveOption
      def parse(regex)
        Regexp.new(regex.source, Regexp::IGNORECASE)
      end
    end
  end

  class File
    attr_reader :lines
    def initialize(path)
      @lines = ::File.read(path).split("\n")
    end

    def grep(pattern)
      lines.select { |line| pattern =~ line }
    end
  end
end

