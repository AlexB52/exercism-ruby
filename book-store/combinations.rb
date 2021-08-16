class Combinations
  def self.for(books)
    new(books).combinations
  end

  attr_reader :books
  def initialize(books)
    @books = books.compact
    @starting_combinations = [Array.new(bundle_number, [])]
  end

  def bundle_number
    books.tally.values.max
  end

  def combinations
    books.uniq.reduce(@starting_combinations) do |combinations, book|
      PossibleCombinations.for(combinations, permutations_for(book))
    end
  end

  def permutations_for(book)
    bundles_for(book)
      .permutation(bundle_number)
      .to_a
      .uniq
  end

  private

  def bundles_for(book)
    number_of_books = books.tally[book]
    Array.new(number_of_books, book) + Array.new(bundle_number - number_of_books)
  end
end
