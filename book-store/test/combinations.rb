require 'minitest/autorun'

class CombinationsTest < MiniTest::Test
  def test_bundle_number
    assert_equal 2, Combination.new([1, 1, 2, 2]).bundle_number
    assert_equal 2, Combination.new([1, 1, 2]).bundle_number
    assert_equal 1, Combination.new([1, 2]).bundle_number
    assert_equal 3, Combination.new([1, 1, 1, 2]).bundle_number
    assert_equal 1, Combination.new([nil, nil, nil, 2]).bundle_number
  end

  def test_bundles_for
    assert_equal [2,nil], Combination.new([1, 1, 2]).bundles_for(2)
    assert_equal [1,1], Combination.new([1, 1, 2]).bundles_for(1)
    assert_equal [2, nil, nil], Combination.new([1, 1, 1, 2]).bundles_for(2)
  end

  def test_permutations_for
    subject = Combination.new([1, 1, 1, 2])

    expected = [
      [2, nil, nil],
      [nil, 2, nil],
      [nil, nil, 2]
    ]

    assert_equal [[1, 1, 1]], subject.permutations_for(1)
    assert_equal expected , subject.permutations_for(2)
  end

  def test_bundles
    expected = [
      [1, 1, 1],
      [2, 2, nil],
      [3, nil, nil],
    ]

    assert_equal expected, Combination.new([1, 1, 1, 2, 2, 3]).bundles
  end

  def test_permutations
    expected = [
      [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1],
      ],
      [
        [2, 2, nil],
        [2, nil, 2],
        [nil, 2, 2],
      ]
    ]

    assert_equal expected, Combination.new([1, 1, 1, 2, 2]).permutations
  end

  def test_possibilities
    expected = [
      [
        [1, 1, 1],
        [2, 2, nil],
        [3, nil, nil],
      ],
      [
        [1, 1, 1],
        [2, nil, 2],
        [nil, 3, nil],
      ],
      [
        [1, 1, 1],
        [nil, 2, 2],
        [nil, nil, 3],
      ]
    ]

    assert_equal expected, Combination.new([1, 1, 1, 2, 2, 3]).possibilities
  end

  def test_combinations
    expected = [
      [
        [1, 2, 3],
        [1, 2],
        [1],
      ],
      [
        [1, 2],
        [1, 3],
        [1, 2],
      ],
      [
        [1],
        [1, 2],
        [1, 2, 3],
      ]
    ]

    assert_equal expected, Combination.new([1, 1, 1, 2, 2, 3]).combinations
    assert_equal expected, Combination.for([1, 1, 1, 2, 2, 3])
  end

  def test_combinations_complex
    expected = [
      [
        [1, 2, 3, 4, 5],
        [1, 2, 3],
      ],
      [
        [1, 2, 3, 4],
        [1, 2, 3, 5],
      ]
    ]

    assert_equal expected, Combination.for([1, 1, 2, 2, 3, 3, 4, 5])
  end
end
