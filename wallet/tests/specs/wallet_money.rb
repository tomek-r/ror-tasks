require 'bundler/setup'
require 'rspec/expectations'
require_relative '../../lib/wallet_money'
require_relative '../../lib/exceptions'


describe WalletMoney do
  subject(:wallet_money_euro) { WalletMoney.new(currency_euro, balance_euro) }
  let(:currency_euro) { :euro }
  let(:balance_euro) { 100 }

  it "should raise exception when no currency is passed" do
    expect { WalletMoney.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should set balance to 0 when no amount is passed" do
    wallet = WalletMoney.new(currency_euro)
    wallet.balance.should == 0
  end

  it "should return currency" do
    wallet_money_euro.currency.should == currency_euro
  end

  it "should return balance" do
    wallet_money_euro.balance.should == balance_euro 
  end

  it "should add 200.5 euro to current balance" do
    wallet_money_euro.add(200.5)
    wallet_money_euro.balance.should == 300.5
  end

  it "should substract 80 euro from balance" do
    wallet_money_euro.substract(20)
    wallet_money_euro.balance.should == 80
  end

  it "should raise exception when substracting value is greater than current balance" do
    expect { wallet_money_euro.substract(101) }.to raise_error(IllegalMoneyValue)
  end

  it "should raise exception when passing no numerical value" do
    expect { wallet_money_euro.substract(nil) }.to raise_error(IllegalArgument)  
  end
end
