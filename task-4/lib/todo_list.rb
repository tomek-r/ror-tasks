require "active_record"
require "todo_item"

class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items
  validates :title, :user_id, :presence => true
  validates_associated :user, :todo_items
end
