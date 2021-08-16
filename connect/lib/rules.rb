class Rules
  def self.for(type, board)
    case type
    when 'X'
      XRule.new(board)
    when 'O'
      ORule.new(board)
    end
  end

  class Rule
    attr_reader :board
    def initialize(board)
      @board = board
    end

    def starting_pieces(pieces)
      pieces.select(&starting_pieces_selection_method)
    end

    def winning_paths?(paths)
      paths.any?(&winning_method)
    end
  end

  class XRule < Rule
    def starting_pieces_selection_method
      Proc.new { |piece| piece.column_coordinate == 0 }
    end

    def winning_method
      Proc.new do |path|
        path.starting_column_coordinate == 0 &&
        path.ending_column_coordinate == board.width
      end
    end
  end

  class ORule < Rule
    def starting_pieces_selection_method
      Proc.new { |piece| piece.row_coordinate == 0 }
    end

    def winning_method
      Proc.new do |path|
        path.starting_row_coordinate == 0 &&
        path.ending_row_coordinate == board.height
      end
    end
  end
end