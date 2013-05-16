#$:.unshift(File.join(File.dirname(__FILE__),"lib"))

module WalletHelper
    def set_accounts(accounts)
        @accounts ||= []
        account.each do |currency, value|
            @accounts << Account.new(currency, value)
        end
    end

    def transfer_money_to_wallet(currency, value)
        account = find_account(currency)
        @wallets ||= []
        if account.check_balance(value)
            @wallets << Wallet.new(currency, value)
            account.substract_money_value(value)
        end
    end

    def get_wallet_money(currency)
        find_wallet(currency).value
    end

    def find_wallet(currency)
        @wallet.find {|wallet| wallet.get_currency == currency }
    end
    
    def get_account_money(currency)
        find_account(currency).value
    end

    def find_account(currency)
        @account.find {|account| account.get_currency == currency }
    end

    def set_exchange_rate(rates)
        @rates ||= []
        rates.each do |(currency_from, currency_to), rate|
            @rates << ExchangeRate.new(currency_from, currency_to, rate)
        end
    end

    def convert_user_money(currency_from, currency_to)
        @converter ||= MoneyConverter.new
        account = find_account(currency_from)
        @converter.convert_money(currency_to, account, find_rate(currency_from, currency_to))
    end

    def set_stock_price(price, currency, stock)
        @stocks ||= []
        stock = find_stock(stock)
        if stock
            stock.add_stock_price(price, currency)
        else
            @stocks << StockSeller.new(price, currency, stock) 
        end
    end
end
