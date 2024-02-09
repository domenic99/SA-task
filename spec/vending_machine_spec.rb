require 'product'
require 'vending_machine'
require 'coin_dispenser'

RSpec.shared_examples 'first product returnable' do
  it { is_expected.to be_an_instance_of(Product) }
  it { is_expected.to eq(vending_machine.products.first) }
end

describe VendingMachine do
  let(:coins) { Hash.new(0).merge(1 => 1) }
  let(:coin_dispenser) { CoinDispenser.new(coins) }

  describe '#select_product' do
    subject(:select_product) { vending_machine.select_product(number) }

    let(:vending_machine) do
      described_class.new([Product.new('test', 1, 1)], coin_dispenser)
    end

    context 'when existing product is selected' do
      let(:number) { 0 }

      it_behaves_like 'first product returnable'
    end

    context 'when non existing product is selected' do
      let(:number) { 1 }

      it { expect { select_product }.to raise_error(StandardError, 'Invalid product') }
    end
  end

  describe '#dispense_product' do
    subject(:dispense_product) { vending_machine.dispense_product }

    let(:vending_machine) do
      described_class.new([Product.new('test', 1, 1)], coin_dispenser)
    end

    before do
      vending_machine.select_product(0)
      vending_machine.insert_coin(coin)
    end

    context 'with sufficient amount' do
      let(:coin) { 1 }

      it_behaves_like 'first product returnable'
    end

    context 'with insufficient amount' do
      let(:coin) { 0.5 }

      it { expect { dispense_product }.to raise_error(StandardError, 'Insufficient cost provided') }
    end

    context 'with sufficient amount and change available' do
      let(:coin) { 2 }

      it_behaves_like 'first product returnable'
    end

    context 'with sufficient amount and no change available' do
      let(:coin) { 3 }

      it { expect { dispense_product }.to raise_error(StandardError, 'There is no change for inserted amount') }
    end
  end
end
