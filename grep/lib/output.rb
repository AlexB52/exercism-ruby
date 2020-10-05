module Grep
  module Output
    module_function

    def print(file_lines, &output_option_block)
      file_lines.map { |file_line| MatchOutput.to_s(file_line, &output_option_block) }
                .uniq
                .join("\n")
    end

    private

    class MatchOutput < SimpleDelegator
      attr_accessor :add_number, :add_filename, :filename_only

      def self.to_s(file_line, &block)
        new(file_line, &block).to_s
      end

      def initialize(file_line)
        __setobj__ file_line
        yield self if block_given?
      end

      def to_s
        return filename if filename_only
        format_filename(format_number(content))
      end

      private

      def format_filename(string)
        return string unless add_filename
        "#{filename}:#{string}"
      end

      def format_number(string)
        return string unless add_number
        "#{number}:#{string}"
      end
    end
  end
end
