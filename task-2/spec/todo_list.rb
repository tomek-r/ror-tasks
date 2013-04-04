require_relative 'spec_helper'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  subject(:list)            { TodoList.new(db: database) }
  let(:database)            { stub }
  let(:item)                { Struct.new(:title,:description,:complete).new(title,description,false) }
  let(:title)               { "Shopping" }
  let(:description)         { "Go to the shop and buy toilet paper and toothbrush" }

  it "should raise an exception if the database layer is not provided" do
    expect{ TodoList.new(db: nil) }.to raise_error(IllegalArgument)
  end

  it "should be empty if there are no items in the DB" do
    stub(database).items_count { 0 }
    list.should be_empty
  end

  it "should not be empty if there are some items in the DB" do
    stub(database).items_count { 1 }
    list.should_not be_empty
  end

  it "should return its size" do
    stub(database).items_count { 6 }

    list.size.should == 6
  end

  it "should persist the added item" do
    stub(database).items_count { 1 }
    mock(database).add_todo_item(item) { true }
    mock(database).get_todo_item(0) { item }

    list << item
    list.first.should == item
  end

  it "should persist the state of the item" do
    stub(database).get_todo_item(0) { item }
    mock(database).complete_todo_item(item,true) { item.complete = true; true }
    mock(database).complete_todo_item(item,false) { item.complete = false; true }

    list.toggle_state(0)
    item.complete.should be_true
    list.toggle_state(0)
    item.complete.should be_false
  end

  it "should fetch the first item from the DB" do
    stub(database).items_count { 1 }

    mock(database).get_todo_item(0) { item }
    list.first.should == item

    stub(database).items_count { 0 }
    list.first.should == nil
  end

  it "should fetch the last item from the DB" do
    stub(database).items_count { 6 }

    mock(database).get_todo_item(5) { item }
    list.last.should == item

    mock(database).get_todo_item(5) { nil }
    list.last.should == nil
  end

  context "with empty title of item" do
    let(:title)   { "" }

    it "should not add the item to the DB" do
      dont_allow(database).add_todo_item(item)

      list << item
    end
  end

  it "should return nil if the DB is empty" do
    stub(database).items_count { 0 }

    list.first.should == nil
    list.last.should == nil
  end

  it "should raise nil exception when changing status for nil item" do
    mock(database).get_todo_item(0) { nil }

    expect{ list.toggle_state(0) }.to raise_error(NilException) 
  end

  it "should refuse nil item" do
    dont_allow(database).add_todo_item(nil)

    list << nil
  end

  context "with too short title of item" do
    let(:title)   { "abcd" }

    it "shouldn't accept an item with too short title (at least 5 chars)" do
      dont_allow(database).add_todo_item(item)
      
      list << item
    end
  end

  context "with missing description of item" do
    let(:without_description)        { Struct.new(:title,:complete).new(title,false) }
   
    it "should accept an item with missing description" do
      mock(database).add_todo_item(without_description) { true }

      list << without_description
    end
  end

  context "with social network" do
    subject(:list)            { TodoList.new(db: database, network: social_network) }
    let(:social_network)      { stub! }
    let(:title)               { "Shopping" }    

    it "should notify social network if an item is added" do
      stub(database).add_todo_item(item) { true }
      mock(social_network).notify(item) { true }

      list << item
    end

    it "should notify social network if an item is completed" do
      stub(database).get_todo_item(0) { item }
      mock(database).complete_todo_item(item,true) { true }
      mock(social_network).notify(item) { true }

      list.toggle_state(0)
    end

    context "with missing title of item" do
      let(:without_title)            { Struct.new(:description,:complete).new(description,false) }
      
      it "shouldn't notify social network if the title of item is missing" do
        stub(database).get_todo_item(0) { without_title }
        dont_allow(social_network).notify

        list << without_title
      end
    end
    context "with missing body of item" do
      let(:without_description)            { Struct.new(:title,:complete).new(title,false) }
      
      it "should notify social network if the body of item is missing" do
        mock(database).add_todo_item(without_description) { true }
        mock(social_network).notify(without_description) { true }

        list << without_description
      end
    end

    context "with too long title of item when notifying social network" do
      let(:title)                         { 'a' * 256 }
      
      it "should truncate the title to 255 chars when adding item" do
        stub(database).add_todo_item(item) { item }
        mock(social_network).notify(item) { true }

        item.title.size.should == 256
        list << item
        item.title.size.should == 255
      end

      it "should truncate the title to 255 chars when completing item" do
        stub(database).get_todo_item(0) { item }
        mock(database).complete_todo_item(item,true) { true }
        mock(social_network).notify(item) { true }

        item.title.size.should == 256
        list.toggle_state(0)
        item.title.size.should == 255
      end
    end
  end
end
