require 'active_record'
require_relative 'util/util'

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
  before_save :encrypt_password

  private 
  def encrypt_password
    self.password = Util.encrypt(self.password)
  end
  
  def self.find_by_email(email)
    where('email = ?', email).first
  end

  def self.find_by_surname(surname)
    where('surname = ?', surname).first
  end

  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if (user != nil)
         return true if user.password == Util.encrypt(password)
         self.increase_failed_login_count(user)
    end
    return false
  end
  
  def self.find_suspicious_users
    where('failed_login_count > 2')
  end

  def self.group_suspicious_users()
    users = self.find_suspicious_users
    users.group_by{ |u| u.failed_login_count }
  end
  
  protected
  def self.increase_failed_login_count(user)
   user.update_attribute(:failed_login_count, user.failed_login_count += 1)
  end
end
