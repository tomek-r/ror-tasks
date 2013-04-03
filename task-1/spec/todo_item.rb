require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_item'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoItem do
  subject(:item)                   { TodoItem.new(item_description) }
  let(:item_description)           { "Buy toilet paper" }

  it "should have the description \"Buy toilet paper\"" do
    item.to_s.should == item_description
  end

  it "should be uncompleted " do
    item.completed.should be_false
  end
end