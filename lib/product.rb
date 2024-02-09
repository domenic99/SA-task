class Product
  attr_reader :name, :price, :stock

  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end

  def decrease_stock!
    @stock -= 1
  end
end
