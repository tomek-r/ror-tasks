require_relative 'test_helper'
require_relative '../lib/todo_list'
require_relative '../lib/user'

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
end
