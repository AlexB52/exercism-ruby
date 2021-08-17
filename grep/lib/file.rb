module Grep
  class File
    FileLine = Struct.new(:content, :number, :filename, keyword_init: true) do
      def match(regex)
        regex =~ content
      end
    end

    attr_reader :path
    def initialize(path)
      @path = path
      @lines_array = ::File.read(path).split("\n")
    end

    def lines
      @lines ||= @lines_array.map.with_index do |line, index|
        FileLine.new(content: line, number: (index + 1), filename: path)
      end
    end
  end
end
