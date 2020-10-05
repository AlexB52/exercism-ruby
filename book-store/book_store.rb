require 'byebug'
require_relative 'combinations'
require_relative 'possible_combinations'

module BookStore
  module_function

  def calculate_price(books)
    Combinations.for(books).map do |combination|
      combination.reduce(0) { |result, bundle| result += price_of_bundle(bundle) }
    end.min
  end

  def price_of_bundle(bundle)
    case bundle.count
    when 0
      0.0
    when 1
      8.0
    when 2
      15.20
    when 3
      21.6
    when 4
      25.6
    when 5
      30
    end
  end
end
