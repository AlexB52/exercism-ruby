require 'byebug'
require 'minitest/autorun'
require_relative 'connect'

# Common test data version: 1.1.0 a02d64d
class ConnectTest < Minitest::Test
  def test_an_empty_board_has_no_winner
    # skip
    board = [
      '. . . . .',
      ' . . . . .',
      '  . . . . .',
      '   . . . . .',
      '    . . . . .'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal '', game.winner, 'an empty board has no winner'
  end

  def test_x_can_win_on_a_1x1_board
    board = [
      'X'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'X', game.winner, 'X can win on a 1x1 board'
  end

  def test_o_can_win_on_a_1x1_board
    board = [
      'O'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'O', game.winner, 'O can win on a 1x1 board'
  end

  def test_only_edges_does_not_make_a_winner
    board = [
      'O O O X',
      ' X . . X',
      '  X . . X',
      '   X O O O'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal '', game.winner, 'only edges does not make a winner'
  end

  def test_illegal_diagonal_does_not_make_a_winner
    board = [
      'X O . .',
      ' O X X X',
      '  O X O .',
      '   . O X .',
      '    X X O O'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal '', game.winner, 'illegal diagonal does not make a winner'
  end

  def test_nobody_wins_crossing_adjacent_angles
    board = [
      'X . . .',
      ' . X O .',
      '  O . X O',
      '   . O . X',
      '    . . O .'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal '', game.winner, 'nobody wins crossing adjacent angles'
  end

  def test_x_wins_crossing_from_left_to_right
    board = [
      '. O . .',
      ' O X X X',
      '  O X O .',
      '   X X O X',
      '    . O X .'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'X', game.winner, 'X wins crossing from left to right'
  end

  def test_o_wins_crossing_from_top_to_bottom
    board = [
      '. O . .',
      ' O X X X',
      '  O O O .',
      '   X X O X',
      '    . O X .'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'O', game.winner, 'O wins crossing from top to bottom'
  end

  def test_x_wins_using_a_convoluted_path
    board = [
      '. X X . .',
      ' X . X . X',
      '  . X . X .',
      '   . X X . .',
      '    O O O O O'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'X', game.winner, 'X wins using a convoluted path'
  end

  def test_x_wins_using_a_spiral_path
    board = [
      'O X X X X X X X X',
      ' O X O O O O O O O',
      '  O X O X X X X X O',
      '   O X O X O O O X O',
      '    O X O X X X O X O',
      '     O X O O O X O X O',
      '      O X X X X X O X O',
      '       O O O O O O O X O',
      '        X X X X X X X X O'
    ].map {|row| row.gsub(/^ */, '')}
    game = Board.new(board)
    assert_equal 'X', game.winner, 'X wins using a spiral path'
  end
end

# class BoardTest < Minitest::Test
#   def test_unit_tests
#     board = [
#       '. O . .',
#       ' O X X X',
#       '  O X O .',
#       '   X X O X',
#       '    . O X .'
#     ].map {|row| row.gsub(/^ */, '')}
#     game = Board.new(board)
#     assert_equal %w(. O X .), game.rows[4]
#     assert_equal %w(. X . X .), game.columns[3]
#     assert_equal 3, game.width
#     assert_equal 4, game.height
#     assert game.send :did_x_win?
#   end
# end

# class NodeTest < Minitest::Test

#   def test_eql?
#     coordinate_1 = Coordinate.new(1, 1)
#     coordinate_2 = Coordinate.new(1, 2)

#     node_1 = Node.new('X', coordinate_1)
#     node_2 = Node.new('X', coordinate_2)
#     node_3 = Node.new('Y', coordinate_1)
#     node_4 = Node.new('.', coordinate_1)

#     assert_equal node_1, Node.new('X', Coordinate.new(1, 1))
#     refute_equal node_2, node_1
#     refute_equal node_3, node_1
#     refute_equal node_4, node_1
#   end

#   def test_nodes
#     board = ['O']
#     expected = [
#       Node.new('O', Coordinate.new(0, 0))
#     ]
#     assert_equal expected, Board.new(board).nodes
#   end

#   class Board2By2Test < Minitest::Test
#     def setup
#       @node_0_0 = Node.new('O', Coordinate.new(0, 0))
#       @node_0_1 = Node.new('.', Coordinate.new(0, 1))
#       @node_1_0 = Node.new('.', Coordinate.new(1, 0))
#       @node_1_1 = Node.new('X', Coordinate.new(1, 1))

#       @board = Board.new [
#         'O .',
#         ' . X'
#       ].map {|row| row.gsub(/^ */, '')}
#     end

#     def test_more_nodes
#       expected = [
#         @node_0_0,
#         @node_0_1,
#         @node_1_0,
#         @node_1_1,
#       ]

#       assert_equal expected, @board.nodes
#     end

#     def test_node_at
#       assert_equal @node_1_0, @board.node_at(Coordinate.new(1, 0))
#     end

#     def test_next_possible_nodes
#       assert_equal [@node_1_0], @board.next_possible_nodes(@node_0_1)
#     end
#   end

#   class Board4By4Test < Minitest::Test
#     def setup
#       @board = Board.new [
#         'O O O X',
#         ' X . . X',
#         '  X . . X',
#         '   X O O O'
#       ].map {|row| row.gsub(/^ */, '')}
#     end

#     def test_next_possible_nodes
#       expected = [
#         Node.new('.', Coordinate.new(1, 2)),
#         Node.new('.', Coordinate.new(2, 1)),
#       ]

#       assert_equal expected, @board.next_possible_nodes(Node.new('.', Coordinate.new(1, 1)))

#       expected = [
#         Node.new('O', Coordinate.new(0, 1)),
#       ]

#       assert_equal expected, @board.next_possible_nodes(Node.new('O', Coordinate.new(0, 0)))
#     end
#   end
# end
