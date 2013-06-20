require "active_record"
require 'todo_list'

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :title, :date_due, :todo_list_id, :presence => true
  validates :description, :length => { :maximum => 255 }
  validate :validate_date_format
  #validates :date_due, :format => { :with => /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/ }
  
  def validate_date_format
     if date_due.class != Time 
        errors.add(:date_due, "is not valid format")
     end
  end

  def self.find_by_word(word)
      where("description LIKE ?", "%#{word}%")
  end

  def self.find_by_long_desc(length)
    where("LENGTH(description) > ?", length)
  end

  def self.paginate(page=1)
    offset = (page - 1) * 2
    limit(2).offset(offset).order(:title)
  end

  def self.find_by_user(id)
    where("todo_items.todo_list_id = todo_lists.id AND todo_lists.user_id = ?", id).includes(:todo_list)
  end

  def self.find_by_user_date(id, date)
      pp Time.parse(date).to_s
    self.find_by_user(id).where('date_due = ?', Time.parse(date).to_s)
  end
end
