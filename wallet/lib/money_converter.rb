class MoneyConverter
  def initialize(account_from, account_to, rate)
    raise IllegalArgument if account_from.nil? or account_to.nil? or rate.nil?
    @account_from = account_from
    @account_to = account_to
    @rate = rate
  end

  def convert(limit=nil)
    if limit.nil?
      to_substract = @account_from.balance  
    else 
      to_substract = limit
    end
    @account_from.substract(to_substract)
    @account_to.add(to_substract * @rate)
  end
end
