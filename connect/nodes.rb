class Nodes < SimpleDelegator
  def self.build(rows)
    nodes = rows.flat_map.with_index do |row, row_index|
      row.map.with_index do |type, column_index|
        Node.new(type, Coordinate.new(row_index, column_index))
      end
    end

    new(nodes)
  end

  def for(type)
    __getobj__.select { |node| node.type == type }
  end
end

Node = Struct.new(:type, :coordinate) do
  def pieces_in_bound?(other_pieces)
    other_pieces.select do |other_piece|
      coordinate.in_bound?(other_piece.coordinate)
    end
  end

  def row_coordinate
    coordinate.row
  end

  def column_coordinate
    coordinate.column
  end
end

Coordinate = Struct.new(:row, :column) do
  def in_bound?(other_coordinate)
    in_bound_coordinates.include? other_coordinate
  end

  private

  def in_bound_coordinates
    [
      Coordinate.new(row - 1, column),
      Coordinate.new(row - 1, column + 1),
      Coordinate.new(row + 1, column),
      Coordinate.new(row, column - 1),
      Coordinate.new(row, column + 1),
      Coordinate.new(row + 1, column - 1),
      Coordinate.new(row + 1, column),
    ]
  end
end