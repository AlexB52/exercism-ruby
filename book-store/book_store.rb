=begin
Write your code for the 'Book Store' exercise in this file. Make the tests in
`book_store_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/book-store` directory.
=end

require 'byebug'
require_relative 'combination'

def price_of_basket(basket)
  case basket.count
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

Book = Struct.new(:id)

class BookStore
  def self.calculate_price(basket)
    return price_of_basket(basket) if basket.uniq == basket

    Combination.for(basket).map do |possiblities|
      possiblities.reduce(0) { |result, bundle| result += price_of_basket(bundle) }
    end.min
  end
end
