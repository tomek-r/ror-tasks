require "active_record"
require 'todo_list'

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :title, :description, :presence => true
  validates :description, :length => { :maximum => 255, :minimum => 0 }
  validate :validate_date_format
  
  def validate_date_format
      if (date_due =~ /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/)== nil
        errors.add(:date_due, "is not valid format (dd/mm/yyyy)")
     end
  end

end
