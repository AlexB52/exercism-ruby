class BookTest < Minitest::Test
  def test_eql
    assert_equal Book.new(1), Book.new(1)
  end
end

class BundleTest < Minitest::Test
  def test_eql
    book_1 = Book.new(1)
    book_2 = Book.new(2)

    assert_equal Set.new([book_1, book_2]), Set.new([book_2, book_1])
  end
end

class SetTest < Minitest::Test
  def setup
    @book_1 = Book.new(1)
    @book_2 = Book.new(2)
    @bundle_1 = Set.new [@book_1]
    @bundle_2 = Set.new [@book_1, @book_2]
    @bundle_3 = Set.new [@book_2, @book_1]
  end

  def test_bundles
    assert_equal Set.new([@bundle_2, @bundle_1]), Set.new([@bundle_1, @bundle_2])
  end

  def test_eql
    assert_equal Set.new([@bundle_1, @bundle_2]), Set.new([@bundle_3, @bundle_1])
    assert_equal Set.new([@bundle_1, @bundle_2]), Set.new([@bundle_3, @bundle_1, @bundle_2])
  end

  def test_uniq
    assert_equal Set.new([@bundle_1, @bundle_2]), Set.new([@bundle_3, @bundle_1, @bundle_2])
  end
end
