class CoinDispenser
  AVAILABLE_COIN_LIST = [0.25, 0.5, 1, 2, 3, 5].freeze

  def initialize(coins)
    @coins = coins
  end

  def add_coin(value)
    raise 'Invalid coin provided' unless valid_coin?(value)

    coins[value] += 1
  end

  def make_change_for(amount)
    res = {}

    coins.keys.sort_by(&:-@).reduce(amount) do |change_remaining, coin|
      coin_number = (change_remaining / coin).to_i.abs
      res[coin] = coins[coin] >= coin_number ? coin_number : coins[coin]
      change_remaining - res[coin] * coin
    end

    res
  end

  def dispense(coins_to_deduct)
    raise 'Cannot dispense such coins' unless sufficient_coins_for?(coins_to_deduct)

    coins_to_deduct.each { |k, v| coins[k] -= v }
  end

  private

  attr_reader :coins

  def valid_coin?(value)
    AVAILABLE_COIN_LIST.include?(value)
  end

  def sufficient_coins_for?(coins_to_deduct)
    coins_to_deduct.each do |k, v|
      return false if coins[k] < v
    end
  end
end
