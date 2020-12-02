class Matrix
  attr_reader :rows, :columns

  def initialize(string)
    @rows    = build_rows string.split("\n")
    @columns = @rows.transpose
  end

  private

  def build_rows(string_rows)
    string_rows.map { |string_row| to_array(string_row) }
  end

  def to_array(string_row)
    string_row.split.map(&:to_i)
  end
end