# frozen_string_literal: true

require_relative 'lib/product'
require_relative 'lib/vending_machine'
require_relative 'lib/coin_dispenser'

vending_machine = VendingMachine.new(
  [Product.new('Snack', 1.25, 12),
   Product.new('Meal', 3.75, 4),
   Product.new('Desert', 0.50, 7)],
  CoinDispenser.new(
    0.25 => 10,
    0.5 => 10,
    1.0 => 10,
    2.0 => 10,
    3.0 => 10,
    5.0 => 10
  )
)

puts 'Hello, here is the list of products that we have'

vending_machine.products.each_with_index do |product, index|
  puts "#{index}. #{product.name} #{product.price}$"
end

step = 0

loop do
  case step
  when 0
    puts 'Please select any product'
    step += 1
  when 1
    input = Integer(gets.strip, exception: false)
    vending_machine.select_product(input)
    step += 1
  when 2
    puts 'Please insert coins to buy selected product'
    step += 1
  when 3
    input = Float(gets.strip, exception: false)
    vending_machine.insert_coin(input)

    puts "You inserted #{input}"
    if vending_machine.sufficient_amount_inserted?
      step += 1
    else
      puts "Your total #{vending_machine.inserted_amount}. Please add more"
    end
  when 4
    product = vending_machine.dispense_product

    puts "You have inserted required amount. Here is your #{product.name}"
    puts "And here is your change #{vending_machine.ask_for_change}"

    step = 0
  end
rescue StandardError => e
  puts e.message
end
