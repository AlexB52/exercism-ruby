module Grep
  class Options
    attr_reader :files, :flags
    def initialize(flags, files)
      @flags = flags
      @files = files
    end

    def regex_for(pattern)
      regex_options.reduce(Regexp.new(pattern)) { |regex, option| option.format_regex(regex) }
    end

    def regex_options
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

    def filenames_only?
      flags.include?('-l')
    end

    def line_number?
      flags.include?('-n')
    end

    def inverted?
      flags.include?('-v')
    end

    def filename?
      files.length > 1
    end

    class Option
      def format_regex(regex)
        regex
      end
    end

    class CaseInsensitiveOption < Option
      def format_regex(regex)
        Regexp.new(regex.source, Regexp::IGNORECASE)
      end
    end

    class FullMatchOption < Option
      def format_regex(regex)
        Regexp.new(/^#{regex.to_s}$/)
      end
    end
  end
end
