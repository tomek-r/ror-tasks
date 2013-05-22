require 'bundler/setup'
require 'rspec/expectations'

require_relative 'test_helper'

describe "virtual wallet" do
    include WalletHelper

    specify "user should transfer euros from account to wallet" do 
        set_accounts :euro => 100
        transfer_money_to_wallet :euro => 100
        get_wallet_money(:euro).should == 100
        get_account_money(:euro).should == 0
    end

    specify "user should convert money from euro to pln" do 
        set_accounts :euro => 100
        transfer_money_to_wallet :euro => 100
        set_exchange_rate [:euro, :pln] => 4.00
        convert_user_money :euro, :pln        
        get_wallet_money(:euro).should == 0
        get_wallet_money(:pln).should == 400
    end

    specify "buy 1 stock of Alior Bank" do
        set_accounts :euro => 200
        transfer_money_to_wallet :euro => 100
        set_stock_price 100, :euro, :alior
        buy_stock 1, :euro,  :alior
        get_user_stocks.should == 1
        get_user_stock(:alior).should == 1
    end

    specify "sell 1 stock of Alior Bank" do
        set_wallet_money :euro => 100
        set_user_stock :alior => 2
        set_stock_price 100, :euro, :alior
        sell_user_stock :alior => 1, :euro
        get_wallet_money(:euro).should == 200
        get_user_stock(:alior).should == 1
    end

    specify "user should transfer money from wallet to account" do
        set_wallet_money :euro => 100
        set_account_money :euro => 0
        transfer_money_to_account :euro, 100
        get_wallet_money(:euro).should == 0
        get_account_money(:euro).should == 100
    end
end
