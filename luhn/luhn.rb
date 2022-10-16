module Luhn
  module_function
  def valid?(input)
    return false unless input.match?(/^\d[\s\d]+$/)

    input.scan(/\d/)
         .reverse_each
         .with_index
         .sum(&luhn_value_proc) % 10 == 0
  end

  def luhn_value_proc
    Proc.new do |digit, index|
      value = digit.to_i
      if index.odd?
        value *= 2
        value -= 9 if value > 9
      end
      value
    end
  end
end