class Combination
  def self.for(books)
    new(books).combinations
  end

  attr_reader :books
  def initialize(books)
    @books = books
  end

  def number_of_books_by_number
    @number_of_books_by_number ||= books.compact.each_with_object({}) do |item, object|
      object[item] ||= 0
      object[item] += 1
    end
  end

  def bundle_number
    @bundle_number ||= number_of_books_by_number.values.max
  end

  def book_numbers
    books.uniq
  end

  def combinations
    possibilities.map do |row|
      row.transpose.map(&:compact)
    end
  end

  def possibilities
    permutations.transpose
  end

  def permutations
    @permutations ||= book_numbers.map do |number|
      if permutations_for(number).count > 1
        permutations_for(number)
      else
        Array.new(bundle_number) { permutations_for(number).flatten }
      end
    end
  end

  def bundles
    @bundles ||= book_numbers.map { |number| bundles_for(number) }
  end

  def permutations_for(number)
    bundles_for(number)
      .permutation(bundle_number)
      .to_a
      .uniq
  end

  def bundles_for(number)
    result = Array.new(number_of_books_by_number[number], number)
    while result.count < bundle_number
      result << nil
    end
    result
  end
end
