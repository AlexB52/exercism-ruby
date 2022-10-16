=begin
Write your code for the 'Luhn' exercise in this file. Make the tests in
`luhn_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/luhn` directory.
=end

module Luhn
  module_function
  def valid?(input)
    return false unless input.match?(/^[\d][\s\d]+$/)

    checksum = 0
    input.scan(/\d/)
         .reverse
         .each
         .with_index do |digit, i|
        value = digit.to_i

        if i % 2 != 0
          value *= 2
          value -= 9 if value > 9
        end
        checksum += value
      end

    checksum % 10 == 0
  end
end