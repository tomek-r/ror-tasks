require 'bundler/setup'
require 'rspec/expectations'
require_relative '../../lib/wallet_money'
require_relative '../../lib/money_converter'
require_relative '../../lib/exceptions'


describe MoneyConverter do
  subject(:converter) { MoneyConverter.new(account_from, account_to, rate) }
  let(:account_from) { WalletMoney.new(:euro, 100) }
  let(:account_to) { WalletMoney.new(:pln, 224.5) }
  let(:rate){ 4.14 }

  it "should convert all money from euro to pln" do
    converter.convert()
    account_from.balance.should == 0
    account_to.balance.should == 224.5 + (100 * 4.14)
  end

  it "should convert from euro to pln with limit" do
    converter.convert(50)
    account_from.balance.should == 50
    account_to.balance.should == 224.5 + (50 * 4.14)
  end

  it "should raise exception when limit is greater than balance" do
    expect { converter.convert(120) }.to raise_error(IllegalMoneyValue)
  end
end 
