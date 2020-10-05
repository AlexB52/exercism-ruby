require 'minitest/autorun'
require_relative 'book_store'

class CombinationsTest < MiniTest::Test
  def test_bundle_number
    assert_equal 2, Combinations.new([1, 1, 2, 2]).bundle_number
    assert_equal 2, Combinations.new([1, 1, 2]).bundle_number
    assert_equal 1, Combinations.new([1, 2]).bundle_number
    assert_equal 3, Combinations.new([1, 1, 1, 2]).bundle_number
    assert_equal 1, Combinations.new([nil, nil, nil, 2]).bundle_number
  end

  def test_permutations_for
    subject = Combinations.new([1, 1, 1, 2, 2, 3])

    expected_1 = [
      [1, 1, 1]
    ]

    expected_2 = [
      [2, 2, nil],
      [2, nil, 2],
      [nil, 2, 2],
    ]

    expected_3 = [
      [3, nil, nil],
      [nil, 3, nil],
      [nil, nil, 3]
    ]

    assert_equal expected_1, subject.permutations_for(1)
    assert_equal expected_2, subject.permutations_for(2)
    assert_equal expected_3, subject.permutations_for(3)
  end

  def test_combinations
    expected = [
      [
        [1, 2],
        [1, 2],
        [1, 3],
      ],
      [
        [1],
        [1, 2],
        [1, 2, 3],
      ]
    ]

    assert_equal expected, Combinations.for([1, 1, 1, 2, 2, 3])
  end

  def test_combinations_complex
    expected = [
      [
        [1, 2, 3, 4],
        [1, 2, 3, 5],
      ],
      [
        [1, 2, 3],
        [1, 2, 3, 4, 5],
      ],
    ]

    assert_equal expected, Combinations.for([1, 1, 2, 2, 3, 3, 4, 5])
  end
end
