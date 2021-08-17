class Output < Struct.new(:matches, :options)
  def self.print(matches:, options:)
    new(matches, options).print
  end

  def print
    return matches_filenames if options.filenames_only?

    matches.map { |match_details| output(match_details) }
           .join("\n")
  end

  def output(match_details)
    OutputMatch.new(match_details).tap do |output|
      output.activate_number   if options.line_number?
      output.activate_filename if options.filename?
    end.to_s
  end

  def matches_filenames
    matches.map(&:filename).uniq.join("\n")
  end

  class OutputMatch < SimpleDelegator
    def initialize(line_detail)
      super
      @add_number = false
      @add_filename = false
    end

    def activate_number
      @add_number = true
    end

    def activate_filename
      @add_filename = true
    end

    def to_s
      format_filename(format_number(content))
    end

    private
    def format_filename(string)
      return string unless @add_filename
      "#{filename}:#{string}"
    end

    def format_number(string)
      return string unless @add_number
      "#{number}:#{string}"
    end
  end
end
