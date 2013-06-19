require 'active_record'

class User < ActiveRecord::Base
  attr_accessor :terms_of_service
  attr_accessible :terms_of_service, :name, :surname, :email, :password, :password_confirmation, :failed_login_count

  has_many :todo_list
  has_many :todo_items, :through => :todo_list
  
  validates :name, :surname, :email, :terms_of_service, :password, :password_confirmation, :failed_login_count, :presence => true
  validates :name, :length => { :maximum => 20 } 
  validates :surname, :length => { :maximum => 30 }
  validates :email, :uniqueness => true,
      :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      :message => "Not valid email" }
  validates :terms_of_service, :acceptance => true
  validates :password, :length => { :minimum => 10 }, :confirmation => true
  validates :password_confirmation, :length => { :minimum => 10 }
  validates :failed_login_count, :numericality => { :only_integer => true }

end
