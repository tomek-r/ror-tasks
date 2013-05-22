class WalletMoney
  attr_reader :currency, :balance 
  
  def initialize(currency, balance = 0)
    raise IllegalArgument if currency.nil? 
    @currency = currency
    @balance = balance
  end
    
  def add(amount)
    check_numerical(amount)
    @balance += amount
  end

  def substract(amount)
    check_numerical(amount)
    check_substract_value(amount)
    @balance -= amount
  end

  private
  def check_numerical(value)
    return true if value =~ /^\d+$/
    true if Float(value) rescue raise IllegalArgument
  end

  private 
  def check_substract_value(amount)
    raise IllegalMoneyValue if amount > @balance
  end
end
