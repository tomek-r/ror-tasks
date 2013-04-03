class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(options = [])
  	raise IllegalArgument if options[:db].nil?
  	@db = options[:db]
  	@network = options[:network] if options[:network]
  end

  def empty?
  	@db.items_count == 0 ? true : false
  end

  def size 
  	@db.items_count
  end

  def << (item)
  	if !item.nil? and defined?(item.title) and item.title.size > 4
  		item.title = truncate_string(item.title)
  		@db.add_todo_item(item)
  		self.notify
  	end
  end

  def first
  	@db.get_todo_item(0) if @db.items_count > 0
  end

  def last
  	@db.get_todo_item(@db.items_count - 1) if @db.items_count > 0
  end

  def toggle_state (index)
  	item = @db.get_todo_item(index)
  	raise NilException if item.nil?
  	item.title = truncate_string(item.title)
  	@db.complete_todo_item(item, !item.complete)
  	if !item.complete 
  		self.notify
  	end
  end

  def notify
  	@network.notify if @network
  end

  def truncate_string(string)
  	string.slice(0, 255)
  end
end
