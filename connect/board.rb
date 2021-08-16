class Board
  attr_reader :nodes, :board
  def initialize(board)
    @board = board
    @nodes = Nodes.build(rows)
  end

  def winner
    "#{players.find(&:winner?)}"
  end

  def width
    @width ||= @rows.transpose.size - 1
  end

  def height
    @height ||= rows.size - 1
  end

  private

  def rows
    @rows ||= board.map(&:split)
  end

  def players
    @players ||= [player('X'), player('O')]
  end

  def player(type)
    Player.new type,
      pieces: nodes.for(type),
      rule: Rules.for(type, self)
  end
end