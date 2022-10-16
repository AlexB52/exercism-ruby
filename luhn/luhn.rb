module Luhn
  module_function
  def valid?(input)
    return false unless input.match?(/^\d[\s\d]+$/)

    input.scan(/\d/)
         .reverse_each
         .with_index
         .sum do |digit, i|
            value = digit.to_i

            if i % 2 != 0
              value *= 2
              value -= 9 if value > 9
            end

            value
          end % 10 == 0
  end
end