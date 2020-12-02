class Board
  attr_reader :nodes, :board
  def initialize(board)
    @board = board
    @nodes = Nodes.build(rows)
  end

  def winner
    "#{players.find(&:winner?)}"
  end

  private

  def rows
    @rows ||= board.map(&:split)
  end

  def players
    @players ||= [build_player('X'), build_player('O')]
  end

  def build_player(type)
    Player.new type,
      pieces: nodes.for(type),
      rule: build_rule(type)
  end

  def build_rule(type)
    Rule.new(
      starting_pieces_selection_method(type),
      winning_path_method(type)
    )
  end

  def winning_path_method(type)
    case type
    when 'X'
      Proc.new do |path|
        path.starting_column_coordinate == 0 &&
        path.ending_column_coordinate == width
      end
    when 'O'
      Proc.new do |path|
        path.starting_row_coordinate == 0 &&
        path.ending_row_coordinate == height
      end
    end
  end

  def starting_pieces_selection_method(type)
    case type
    when 'X'
      Proc.new { |piece| piece.column_coordinate == 0 }
    when 'O'
      Proc.new { |piece| piece.row_coordinate == 0 }
    end
  end

  def width
    @width ||= @rows.transpose.size - 1
  end

  def height
    @height ||= rows.size - 1
  end
end