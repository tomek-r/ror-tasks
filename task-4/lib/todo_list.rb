require "active_record"
require "todo_item"
require "user"

class TodoList < ActiveRecord::Base
  belongs_to :user
  validates :title, :user_id, :presence => true
  validates_associated :user, :todo_items

  has_many :todo_items

  def self.find_by_title(title)
   where("title = ?", title)
  end

  def self.find_by_user(id)
   where("user_id = ?", id)
  end

  def self.find_by_id_with_items(id)
    where("id = ?", id).includes(:todo_items).first
  end
end
