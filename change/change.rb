class Change
  class ImpossibleCombinationError < StandardError ;end
  class NegativeTargetError < StandardError ;end

  def self.generate(coins, change)
    raise NegativeTargetError if change < 0

    coins_per_change = (1..change).each.with_object({ 0 => [] }) do |i, obj|
      obj[i] = coins
        .map { |coin| [coin].concat(obj[i-coin] || []) }
        .select { _1.sum == i }
        .min_by(&:length)
    end

    coins_per_change[change] || raise(ImpossibleCombinationError)
  end
end
