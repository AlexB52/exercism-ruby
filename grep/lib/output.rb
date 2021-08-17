class Output < Struct.new(:matches, :options)
  def self.print(matches:, options:)
    new(matches, options).print
  end

  def print
    return matches_filenames if options.filenames_only?

    matches.map { |line_details| output(line_details) }
           .join("\n")
  end

  def output(line_details)
    OutputMatch.new(line_details) do |output|
      output.add_number   = options.line_number?
      output.add_filename = options.filename?
    end.to_s
  end

  def matches_filenames
    matches.map(&:filename).uniq.join("\n")
  end

  class OutputMatch < SimpleDelegator
    attr_accessor :add_number, :add_filename

    def initialize(line_details, &block)
      __setobj__ line_details
      yield self if block_given?
    end

    def to_s
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
