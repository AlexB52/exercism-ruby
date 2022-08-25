class Change
  class ImpossibleCombinationError < StandardError ;end
  class NegativeTargetError < StandardError ;end

  def self.generate(coins, change)
    if change < 0
      raise NegativeTargetError
    end

    unless (result = self.coins_per_change3(coins, change)[change])
      raise ImpossibleCombinationError
    end

    result
  end

  def self.coins_per_change(coins, max)
    (1..max).each.with_object({ 0 => [] }) do |i, result|
      coins.each do |coin|
        target = i-coin
        if result[target]
          combination = [coin].concat(result[target])
          result[i] ||= combination
          result[i] = [result[i], combination].min_by(&:length)
        end
      end
    end
  end

  def self.coins_per_change2(coins, max)
    (1..max).each.with_object({ 0 => [] }) do |i, result|
      result[i] = coins
        .map { |coin| [coin].concat(result[i-coin] || []) }
        .select { _1.sum == i }
        .min_by(&:length)
    end
  end

  def self.coins_per_change3(coins, max)
    Hash.new do |h, k|
      if k <= 0
        h[0] = []
      else
        h[k] = coins
          .map { |coin| [coin].concat(h[k-coin] || []) }
          .select { _1.sum == k }
          .min_by(&:length)
      end
    end
  end
end

require 'benchmark'

n = 50
Benchmark.bm do |x|
  x.report("sol 1") { n.times { Change.coins_per_change([1, 2, 5, 10, 20, 50, 100],1999) } }
  x.report("sol 2") { n.times { Change.coins_per_change2([1, 2, 5, 10, 20, 50, 100],1999) } }
  x.report("sol 3") { n.times { Change.coins_per_change3([1, 2, 5, 10, 20, 50, 100],1999)[1999] } }
end

