require "byebug"

class Alphametics
  def self.solve(puzzle)
    new(puzzle).solve
  end

  attr_accessor :puzzle
  def initialize(puzzle)
    @puzzle = puzzle
  end

  def solve
    (0..9).to_a.permutation(coefficients.count) do |permutation|
      sum = permutation
        .zip(coefficients.values)
        .map{ |x, y| x * y }
        .sum

      result = coefficients.keys.zip(permutation).to_h

      return result if sum.zero? && valid?(result)
    end
    return {}
  end

  def words
    @words ||= puzzle.scan(/[A-Z]+/)
  end

  def valid?(combination)
    words.map { |word| word.each_char.first }
         .uniq
         .all? { |letter| combination[letter] != 0 }
  end

  def coefficients
    @coefficients ||= begin
      *coeffs, expectation = words

      result = Hash.new { |h, k| h[k] = 0 }

      coeffs.each do |coeff|
        coeff.reverse.each_char.with_index do |letter, power|
          result[letter] += 10 ** power
        end
      end

      expectation.reverse.each_char.with_index do |letter, power|
        result[letter] -= 10 ** power
      end

      result.sort.to_h
    end
  end
end
