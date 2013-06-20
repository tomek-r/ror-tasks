# encoding: utf-8
require_relative 'test_helper'
require_relative '../lib/todo_item'
require_relative '../lib/todo_list'
require_relative '../lib/user'

describe TodoItem do
  include TestHelper
  subject(:todo_item) { TodoItem.create(attributes) }
  let(:attributes) { { :title => title, :todo_list_id => todo_list_id, :date_due => date_due, :description => description } }
  let(:title) { "Write a game" }
  let(:todo_list_id) { 1 }
  let(:date_due) { "12/06/2013" }
  let(:description) { "Publish it!" }

  it { should be_valid }  

  context "with empty title" do
    let(:title) { "" }
    it { should_not be_valid }
  end

  context "with empty list it belongs to" do
    let(:todo_list_id) { "" }
    it { should_not be_valid }
  end

  context "with description maximum 255 characters long" do
    let(:description) { "1" * 256}
    it { should_not be_valid }
  end

  context "with empty desciption" do
    let(:desciption) { "" }
    it { should be_valid }
  end

  context "DB tests" do
    it "should find by word in descriptions" do
      TodoItem.find_by_word("matematyka").size.should == 1
    end

    it "shouldn't find items that description is longer than 100 letters" do
      TodoItem.find_by_long_desc(100).size.should == 0
    end

    it "should paginate items (2 per page) and order by title" do
      items = TodoItem.paginate(1)
      items.size.should == 2
      items[0].title.should == "Napisać grę"
      items[1].title.should == "Odrobić lekcje"

      items = TodoItem.paginate(2)
      items.size.should == 1
    end

    it "should find items which belong to user" do
      items = TodoItem.find_by_user(1)
      items.size.should == 2
    end
  end
end
