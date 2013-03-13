require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_item'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'


print_style = <<END
[x] Buy toilet paper
[ ] Wash a car
[ ] Learn to fly
END

describe Item do
  subject(:item)                   { Item.new(item_description) }
  let(:item_description)           { "Buy toilet paper" }

  it "should have the description \"Buy toilet paper\"" do
    item.to_s.should == item_description
  end

  it "should be uncompleted " do
    item.completed.should be_false
  end

  it "should change state to completed" do
    item.complete().should be_true
  end
end

describe TodoList do
  subject(:list)                   { TodoList.new(items) }
  let(:items)                      { [] }
  let(:item_description)           { "Buy toilet paper" }
  let(:item_second_description)    { "Wash a car" }
  let(:item_third_description)     { "Learn to fly" }

  it { should be_empty }

  it "should raise an exception when nil is passed to the constructor" do
    expect { TodoList.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should have size of 0" do
    list.size.should == 0
  end

  it "should accept an item" do
    list << item_description
    list.should_not be_empty
  end

  it "should add the item to the end" do
    list << item_description
    list.last.to_s.should == item_description
  end

  it "should have the added item uncompleted" do
    list << item_description
    list.completed?(0).should be_false
  end

  context "with one item" do
    let(:items)             { [item_description] }

    it { should_not be_empty }

    it "should raise an exception when passing non existing index" do
      expect { list.get(1) }.to raise_error(IllegalArrayIndex)
    end

    it "should have size of 1" do
      list.size.should == 1
    end

    it "should have the first and the last item the same" do
      list.first.to_s.should == list.last.to_s
    end

    it "should not have the first item completed" do
      list.completed?(0).should be_false
    end

    it "should change the state of a completed item" do
      list.complete(0)
      list.completed?(0).should be_true
    end

    it "should change the state of a uncompleted item" do
      list.complete(0)
      list.uncomplete(0)
      list.completed?(0).should be_false
    end

    it "should toggle the state of item" do
      list.complete(0)
      list.toggle_completed(0)
      list.completed?(0).should be_false
    end

    it "should change description of item" do
      list.change_description(0, 'Go to disco')
      list.get(0).to_s.should == 'Go to disco'
    end

    it "should get the item at index" do
      list.get(0).to_s.should == item_description
    end

  end
  context "with two items" do
    let(:items)             { [item_description, item_second_description] }

    it { should_not be_empty }

    it "should have size of 2" do
      list.size.should == 2
    end

    it "should get all completed items" do
      list.complete(1)
      list.get_completed.size == 1
    end

    it "should get all uncompleted items" do
      list.get_uncompleted.size == 2
    end

    it "should remove an individual item" do
      list.remove(0)
      list.first.to_s.should == item_second_description
    end

    it "should remove all completed items" do
      list.complete(0)
      list.complete(1)
      list.remove_completed
      list.size.should == 0
    end

    it "should revert order of two items" do
      list.revert(0, 1)
      list.get(0).to_s.should == item_second_description
      list.get(1).to_s.should == item_description
    end
  end

  context "with three items" do
    let(:items)             { [item_description, item_second_description, item_third_description] } 

    it "should have size of 3" do
      list.size.should == 3
    end

    it "should raise an exception when passing non existing index" do
      expect { list.revert 2, 3 }.to raise_error(IllegalArrayIndex)
    end

    it "should revert order of two items" do
      list.revert 1, 2
      list.get(1).to_s.should == item_third_description
      list.get(2).to_s.should == item_second_description
    end

    it "should revert order of all items" do
      list.revert
      list.get(0).to_s.should == item_third_description
      list.get(1).to_s.should == item_second_description
      list.get(2).to_s.should == item_description
    end

    it "should sort item by name" do
      list.sort
      list.get(0).to_s.should == item_description
      list.get(1).to_s.should == item_third_description
      list.get(2).to_s.should == item_second_description
    end

    it "should return all items using following format -> [x] - completed item, [ ] uncompleted item" do
      list.complete(0)
      list.to_s.should == print_style
    end

  end
end
