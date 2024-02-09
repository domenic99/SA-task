class VendingMachine
  attr_reader :products, :inserted_amount

  def initialize(products, coin_dispenser)
    @products = products
    @coin_dispenser = coin_dispenser
    @inserted_amount = 0
    @inserted_coins = Hash.new(0)
    @selected_product = nil
  end

  def select_product(number)
    product = products[number]

    raise 'Invalid product' if product.nil? || product.stock < 1

    @selected_product = product
  end

  def insert_coin(value)
    raise 'Select product first' if selected_product.nil?

    coin_dispenser.add_coin(value)
    @inserted_coins[value] += 1
    @inserted_amount += value
  end

  def sufficient_amount_inserted?
    selected_product && inserted_amount >= selected_product.price
  end

  def dispense_product
    raise 'Insufficient cost provided' unless sufficient_amount_inserted?
    raise 'There is no change for inserted amount' unless change_for_inserted_amount_possible?

    selected_product.decrease_stock!
    product = selected_product
    @inserted_amount -= selected_product.price
    @selected_product = nil
    product
  end

  def ask_for_change
    change_coins = coin_dispenser.make_change_for(inserted_amount)
    reset_inserted_amount
    coin_dispenser.dispense(change_coins)
  end

  def refund
    reset_inserted_amount
    reset_inserted_coins
  end

  private

  attr_reader :selected_product, :coin_dispenser, :inserted_coins

  def change_for_inserted_amount_possible?
    change = inserted_amount - selected_product.price
    coin_dispenser.make_change_for(change).sum { _1 * _2 } == change
  end

  def reset_inserted_amount
    @inserted_amount = 0
  end

  def reset_inserted_coins
    coin_dispenser.dispense(inserted_coins)
    inserted_coins.clear
  end
end
