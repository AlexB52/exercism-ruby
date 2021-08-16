class Path
  def self.traverse(starting_nodes, pieces)
    starting_nodes.flat_map do |starting_node|
      new(starting_node, pieces).traverse
    end
  end

  attr_reader :starting_piece, :current_piece,
              :pieces_visited, :pieces

  alias       :ending_piece :current_piece

  def initialize(starting_piece, pieces)
    @pieces = pieces
    @current_piece = @starting_piece = starting_piece
    @pieces_visited = [@current_piece]
  end

  def current_piece=(piece)
    @current_piece = piece
    @pieces_visited << @current_piece
  end

  def traverse
    return [self] if next_pieces.empty?

    next_pieces.flat_map do |next_piece|
      self.dup.tap { |path| path.current_piece = next_piece }
        .traverse
    end
  end

  def starting_column_coordinate
    starting_piece.column_coordinate
  end

  def starting_row_coordinate
    starting_piece.row_coordinate
  end

  def ending_column_coordinate
    ending_piece.column_coordinate
  end

  def ending_row_coordinate
    ending_piece.row_coordinate
  end

  private

  def next_pieces
    current_piece.pieces_in_bound? possible_pieces
  end

  def possible_pieces
    pieces - pieces_visited
  end
end
