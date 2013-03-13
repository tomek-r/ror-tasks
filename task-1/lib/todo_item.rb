class Item
  attr_accessor :completed, :description

  def initialize (description = '')
	  @description = description
	  @completed = false
  end
  
  def to_s
    @description
  end  
end
