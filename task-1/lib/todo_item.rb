class TodoItem
  attr_accessor :completed, :description

  # Initialize the TodoItem with description.
  def initialize (description = '')
    @description = description
    @completed = false
  end
  
  # Returns description.
  def to_s
    @description
  end  

  # Returns nice formated item.
  def formated
  	if @completed
      x = 'x'
    else
      x = ' '
    end
    "- [%s] %s\n" % [x, @description]
  end
end
