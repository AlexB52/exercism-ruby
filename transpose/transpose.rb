class Transpose
  def self.transpose(input)
    new(input).transpose
  end

  attr_reader :input, :line_length
  def initialize(input)
    @line_length = 1
    @input = input
  end

  def transpose
    return "" if input.empty?

    columns.reverse
           .map { |column| format(column) }
           .reverse
           .join("\n")
  end

  def rows
    input.split("\n")
         .map { |row| row.ljust(max_length).split("") }
  end

  def columns
    rows.transpose
  end

  def max_length
    @max_length ||= input.split("\n").map(&:length).max
  end

  def format(row)
    result = row.join.rstrip
    @line_length = [result.length, line_length].max
    result.ljust(line_length)
  end
end

