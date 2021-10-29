Transpose = Struct.new(:input) do
  EMPTY_CHAR = "\u0000"

  def self.transpose(input)
    new(input).transpose
  end

  def transpose
    lines.map(&justify_and_pad)
         .transpose
         .map(&:join)
         .join("\n")
         .gsub(/#{EMPTY_CHAR}+$/, "")
         .gsub(/#{EMPTY_CHAR}/, " ")
  end

  def lines
    @lines ||= input.split("\n")
  end

  private

  def justify_and_pad
    -> (row) { row.ljust(max_length, EMPTY_CHAR).split("") }
  end

  def max_length
    @max_length ||= lines.map(&:length).max
  end
end
