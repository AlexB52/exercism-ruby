require "byebug"
class Change
  def self.coins_per_change(coins, max)
    result = Hash.new do |h, k|
      if k <= 0
        h[0] = []
      elsif coins.include?(k)
        h[k] = [k]
      else
        h[k] = coins
          .filter_map { |coin| [coin].concat(h[k-coin]) }
          .select { _1.sum == k }
          .min_by(&:length)
      end
    end

    result[max]
    result
  end
end

require "minitest/autorun"

class TestChange < MiniTest::Test
  def test_coins_per_change
    expected = {
      0=>[],
      1=>[1],
      2=>[2],
      3=>[1, 2],
      4=>[4],
      5=>[1, 4],
      6=>[2, 4],
      7=>[1, 2, 4],
      8=>[8],
      9=>[1, 8],
      10=>[2, 8]
    }

    assert_equal(expected, Change.coins_per_change([1, 2, 4, 8], 10))
  end
end

  # def self.coins_per_change(coins, max)
  #   (1..max).each.with_object({ 0 => [] }) do |i, result|
  #     coins.each do |coin|
  #       target = i
  #       combination = []

  #       until target <= 0
  #         target -= coin
  #         combination << coin
  #         if result[target]
  #           combination.concat(result[target])
  #           target = 0
  #         end
  #       end

  #       if target == 0
  #         result[i] ||= combination
  #         result[i] = [result[i], combination].min_by(&:length)
  #       end
  #     end
  #   end
  # end
