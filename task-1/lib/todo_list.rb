class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items.nil?
      raise IllegalArgument
    end
    @list = []
    items.map { |item| @list << Item.new(item) }
  end

  def empty?
    @list.empty?
  end

  def size
    @list.size
  end

  def << (item)
    @list << Item.new(item)
  end

  def last
    @list.last
  end

  def completed? (index)
    @list[index].completed
  end

  def first
    @list.first
  end

  def complete (index)
    @list[index].completed = true
  end

  def uncomplete (index)
     @list[index].completed = false
  end
  
  def get (index)
    if index < 0 or index > @list.size - 1
      raise IllegalArrayIndex
    end
    @list.at(index)
  end
  
  def get_completed
    @list.select { |item| item.completed }
  end

  def get_uncompleted
    @list.select { |item| !item.completed }
  end

  def toggle_completed (index)
    @list[index].completed = !@list[index].completed
  end
  
  def remove (index)
    if index < 0 or index > @list.size
      raise IllegalArrayIndex
    end
    @list.delete_at(index) if index
  end

  def remove_completed 
    @list.delete_if { |item| item.completed }
  end

  def revert (one = nil, two = nil)
    if !one.nil? and !two.nil?
      if one < 0 or one > @list.size - 1 or two < 0 or two > @list.size - 1 or two == one 
        raise IllegalArrayIndex
      end
      @list[one], @list[two] = @list[two], @list[one]
    else
      @list.reverse!
    end
  end

  def sort (field = 'description')
    @list.sort_by! { |item| item.description }
  end

  def change_description (index, description = '')
    @list.at(index).description = description
  end

  def to_s
    text = ''
    @list.each do |item|
      if item.completed
        x = 'x'
      else
        x = ' '
      end
      text += "[%s] %s\n" % [x, item.description]
    end
    text
  end
end
