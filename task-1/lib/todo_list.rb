##
# This class represents list of items.

class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items.nil?
      raise IllegalArgument
    end
    @list = []
    items.map { |item| @list << TodoItem.new(item) }
  end

  # Check if +items+ list is empty.
  def empty?
    @list.empty?
  end

  # Returns number of +items+.
  def size
    @list.size
  end

  # Adds item to the list.
  def << (item)
    @list << TodoItem.new(item)
  end

  # Returns the last item from the list.
  def last
    @list.last
  end

  # Returns status of item
  def completed? (index)
    @list[index].completed
  end

  # Returns the first item from the list.
  def first
    @list.first
  end

  # Changes status of item to completed.
  def complete (index)
    @list[index].completed = true
  end

  # Changes status of item to uncompleted.
  def uncomplete (index)
     @list[index].completed = false
  end
  
  # Returns single item.
  def [](index)
    check_index(index)

    @list[index]
  end
  
  # Returns all completed +items+.
  def get_completed
    @list.select { |item| item.completed }
  end

  # Returns all uncompleted +items+.
  def get_uncompleted
    @list.reject { |item| item.completed }
  end

  # Changes status of single item:
  # if completed to uncompleted, if uncompleted to completed.
  def toggle (index)
    check_index(index)

    @list[index].completed = !@list[index].completed
  end
  
  # Removes single item.
  def remove (index)
    check_index(index)

    @list.delete_at(index)
  end

  # Removes all completed items.
  def remove_completed 
    @list.delete_if { |item| item.completed }
  end

  # Reverses the order of +items+ in the list.
  # If two arguments are present then changes order of two items, otherwise reverses all +items+.
  def revert (one = nil, two = nil)
    if !one.nil? or !two.nil?
      check_index(one)
      check_index(two)
      if two == one 
        raise IllegalArrayIndex
      end
      @list[one], @list[two] = @list[two], @list[one]
    else
      @list.reverse!
    end
  end

  # Sorts +items+ by the description. 
  def sort
    @list.sort_by! { |item| item.description.downcase }
  end

  # Changes description of item.
  def change_description (index, description = '')
    check_index(index)

    @list[index].description = description
  end

  # Prints +items+ using nice format
  def to_s
    (@list.map { |item| item.formated }).join("")
  end

  # Raises exception when index doesn't exists.
  def check_index (index)
  	if index < 0 or index > @list.size - 1
      raise IllegalArrayIndex
    end
  end
end
