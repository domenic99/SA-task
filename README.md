This repo contains code fore SA test task.

`vending_console.rb` is an example of implementation for Vending Machine interaction through console

You can use Vending Machine in your desired way

Main class is `VendingMachine`. To use it you have to provide an array of `Product` as first argument, second argument expects an instance of `CoinDispenser`.
Here is an example
```
VendingMachine.new(
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
```
