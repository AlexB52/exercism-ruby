class Change
  class ImpossibleCombinationError < StandardError ;end
  class NegativeTargetError < StandardError ;end

  def self.generate(coins, change)
    if change < 0
      raise NegativeTargetError
    end

    coins_per_change = (1..change).each.with_object({ 0 => [] }) do |i, obj|
      obj[i] = coins
        .map { |coin| [coin].concat(obj[i-coin] || []) }
        .select { _1.sum == i }
        .min_by(&:length)
    end

    unless (result = coins_per_change[change])
      raise ImpossibleCombinationError
    end

    result
  end
end

