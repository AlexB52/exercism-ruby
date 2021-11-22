class SumOfMultiples
  attr_reader :factors
  def initialize(*factors)
    @factors = factors.delete_if(&:zero?)
  end

  def to(number_limit)
    number_limit.times.sum { |number| multiple_exists?(number) ? number : 0 }
  end

  private

  def multiple_exists?(number)
    factors.any? { |factor| number.modulo(factor).zero? }
  end
end