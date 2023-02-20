class Alphametics
  def self.solve(puzzle)
    new(puzzle).solve
  end

  attr_reader :puzzle, :words
  def initialize(puzzle)
    @puzzle = puzzle
    @words = puzzle.scan(/[A-Z]+/)
  end

  def solve
    (0..9).to_a.permutation(coefficients.count) do |permutation|
      next unless permutation
        .zip(coefficients_values)
        .sum { |x, y| x * y }
        .zero?

      result = coefficients_keys.zip(permutation).to_h

      return result if valid?(result)
    end
    return {}
  end

  private

  def valid?(combination)
    leading_letters.all? { |letter| combination[letter] != 0 }
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

  def leading_letters
    @leading_letters ||= words
      .map { |word| word[0] }
      .uniq
  end

  def coefficients_values
    @coefficients_values ||= coefficients.values
  end

  def coefficients_keys
    @coefficients_keys ||= coefficients.keys
  end
end
