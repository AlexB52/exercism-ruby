Player = Struct.new(:type, :pieces, :rule, keyword_init: true) do
  alias to_s type

  def winner?
    rule.winning_paths?(paths)
  end

  def paths
    @paths = Path.traverse rule.starting_pieces(pieces), pieces
  end
end
