#!/bin/env ruby
# encoding: utf-8

require_relative 'test_helper'
require_relative '../lib/todo_list'
require_relative '../lib/user'
require_relative '../lib/todo_item'

describe TodoList do
  include TestHelper
  subject(:todo_list) { TodoList.new(attributes) }
  let(:attributes) { { :title => title, :user_id => user_id } }
  let(:title) { "Smile" }
  let(:user_id) { 1 }

  it { should be_valid }

  context "with empty title" do
    let(:title) { '' }
    it { should_not be_valid }
  end

  context "with empty user" do
    let(:user_id) { nil }
    it { should_not be_valid }
  end

  context "DB tests" do
   it "should find list by title" do
     lists = TodoList.find_by_title("Przyjemności")
     lists.size.should == 1
   end

   it "should find all lists that belongs to user" do
     lists = TodoList.find_by_user(1)
     lists.size.should == 2
   end

   it "should find all items that belong to given list" do
     lists = TodoList.find_by_id_with_items(1)
     lists.todo_items.size.should == 2
   end
  end
end
