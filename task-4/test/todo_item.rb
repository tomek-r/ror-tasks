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
  it "ala" do
    pp todo_item.errors
  end
  context "with empty title" do
    #let(:title) { '' }
    #it { should_not be_valid }
  end

  #context "with empty user" do
    #let(:user_id) { nil }
    #it { should_not be_valid }
  #end
end
