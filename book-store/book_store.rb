=begin
Write your code for the 'Book Store' exercise in this file. Make the tests in
`book_store_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/book-store` directory.
=end

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

class BookStore
  def self.calculate_price(basket)
    return price_of_basket(basket) if basket.uniq == basket

    8.0 * basket.count
  end
end

