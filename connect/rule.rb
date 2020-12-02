Rule = Struct.new(:starting_pieces_selection_method, :winning_method) do
  def starting_pieces(pieces)
    pieces.select(&starting_pieces_selection_method)
  end

  def winning_paths?(paths)
    paths.any?(&winning_method)
  end
end
