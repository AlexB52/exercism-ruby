class Change
  def self.generate(coins, change)
    return [change] if coins.include?(change)

    result = []
    coins.sort.reverse.each do |coin|
      next if coin > change
      number, rest = change.divmod(coin)
      result.concat(Array.new(number) { coin })
      change = rest
      break if change.zero?
    end
    result.sort
  end
end