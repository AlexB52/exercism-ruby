class Change
  class ImpossibleCombinationError < StandardError ;end
  class NegativeTargetError < StandardError ;end

  def self.generate(coins, change)
    if change < 0
      raise NegativeTargetError
    end

    unless (result = self.ways(coins, change)[change])
      raise ImpossibleCombinationError
    end

    result
  end

  def self.ways(coins, max)
    (1..max).each.with_object({ 0 => [] }) do |i, result|
      coins.each do |coin|
        target = i
        combination = []

        until target <= 0
          target -= coin
          combination << coin
          if result[target]
            combination.concat(result[target])
            break
          end
        end

        if combination.sum == i
          result[i] ||= combination
          result[i] = [result[i], combination].min_by(&:length)
        end
      end
    end
  end
end
