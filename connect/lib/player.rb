class Player
  attr_reader :type, :pieces, :rule
  def initialize(type, pieces:, rule:)
    @type, @pieces, @rule = [type, pieces, rule]
  end

  def paths
    @paths = Path.traverse rule.starting_pieces(pieces), pieces
  end

  def winner?
    rule.winning_paths?(paths)
  end

  def to_s
    type
  end
end
