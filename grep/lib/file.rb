module Grep
  class File < Struct.new(:path)
    FileLine = Struct.new(:content, :number, :filename, keyword_init: true) do
      def match(regex)
        regex =~ content
      end
    end

    def lines
      @lines ||= ::File.read(path)
        .split("\n")
        .map.with_index(1) do |line, index|
          FileLine.new(content: line, number: index, filename: path)
        end
    end
  end
end
