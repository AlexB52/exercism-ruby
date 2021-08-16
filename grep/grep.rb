=begin
Write your code for the 'Grep' exercise in this file. Make the tests in
`grep_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/grep` directory.
=end

module Grep
  module_function

  def grep(pattern, flags, files)
    pattern = Regexp.new(pattern)
    files.flat_map do |file|
      File.new(file).grep(pattern)
    end.first
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

