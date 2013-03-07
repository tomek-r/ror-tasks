class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items.nil?
        raise IllegalArgument
    end
    @list = items
    @completed = Hash.new(false)
  end
  def empty?
    @list.empty?
  end
  def size
    @list.size
  end
  def << (item)
    @list << item
  end
  def last
    @list.last
  end
  def completed? (index)
    @completed[index]
  end
  def first
    @list.first
  end
  def complete (index)
    @completed[index] = true
  end
end
