require 'active_record'

class User < ActiveRecord::Base
  has_many :todo_list
  has_many :todo_items, :through => :todo_list
  validates :name, :presence => true, :length => { :maximum => 20 } 
  validates :surname, :presence => true, :length => { :maximum => 30 }
  validates :email, :preence => true, :uniqueness => true,
      :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      :message => "Not valid email" }
  validates :terms_of_service, :presence => true
  validates :password, :presence => true, :length => { :minimum => 10 }
  validates :password_confirmation
end
