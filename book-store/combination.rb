require 'set'

module Bundle
  module_function

  def for(combinations, new_array)
    uniqueness merge(combinations, new_array)
  end

  def merge(combinations, new_array)
    permutations = new_array.permutation(new_array.length).uniq

    combinations.flat_map do |bundles|
      permutations.map do |permutation|
        bundles.dup.zip(permutation).map do |new_bundle|
          new_bundle.flatten.compact
        end
      end
    end
  end

  def uniqueness(combinations)
    combinations.each_with_object(Set.new) do |combination, object|
      object << combination.sort
    end.to_a
  end
end

class Combination
  def self.for(books)
    new(books).combinations
  end

  attr_reader :books
  def initialize(books)
    @books = books.compact
  end

  def self.test_for(books)
    combination = new(books)
    combinations = [combination.starting_bundles]

    (combination.unique_books - combination.starting_bundle).each do |book|
      combinations = Bundle.for(combinations, combination.bundles_for(book))
    end

    combinations
  end

  def starting_bundle
    book_count_by_id
      .filter_map { |book, count| book if count == bundle_number }
  end

  def starting_bundles
    Array.new(bundle_number, starting_bundle)
  end

  def book_count_by_id
    @book_count_by_id ||= books.tally
  end

  def bundle_number
    book_count_by_id.values.max
  end

  def combinations
    combinations = [starting_bundles]

    (unique_books - starting_bundle).each do |book|
      combinations = Bundle.for(combinations, bundles_for(book))
    end

    combinations
  end

  def unique_books
    books.uniq
  end

  def bundles
    @bundles ||= unique_books.map { |number| bundles_for(number) }
  end

  def permutations_for(number)
    bundles_for(number)
      .permutation(bundle_number)
      .to_a
      .uniq
  end

  def bundles_for(number)
    result = Array.new(book_count_by_id[number], number)
    while result.count < bundle_number
      result << nil
    end
    result
  end
end
