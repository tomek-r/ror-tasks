require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper
  subject(:user) { User.new(attributes) }
  let(:attributes) { { :name => name, :surname => surname, :terms_of_service => terms_of_service, :email => email, :password => password, :password_confirmation => password_confirmation, :failed_login_count => failed_login_count } }
  let(:name) { "Anna" }
  let(:surname) { "Kowalska" }
  let(:terms_of_service) { "1" }
  let(:email) { "anna@kowalska.pl" }
  let(:password) { "alaalaalaala" }
  let(:password_confirmation) { "alaalaalaala" }
  let(:failed_login_count) { 1 }

  it { should be_valid }
 
  context "with empty name" do
      let(:name) { '' }
      it { should_not be_valid }
  end

  context "with too long name" do
    let(:name) { "b" * 31 }
    it { should_not be_valid }
  end

  context "with empty surname" do
    let(:surname) { "" }
    it {should_not be_valid}
  end

  context "with too long surname" do
    let(:surname) { "a" * 31 }
    it { should_not be_valid}
  end
  
  context "with invalid email" do
    let(:email) { "ala@" }
    it { should_not be_valid }  

    let (:email) { "ala@wp" }
    it { should_not be_valid }
  end
  
  context "with not accepted terms of service" do
    let(:terms_of_service) { 1 }
    it { should_not be_valid } 
  end

  context "with empty password" do
    let(:password) {''}
    it { should_not be_valid }
  end

  context "with too short password" do 
    let(:password) { "ala123" }
    it { should_not be_valid }
  end
  
  context "with wrong password confirmation" do
    let(:password_confirmation) { "lato123" }
    it { should_not be_valid }
  end
  
  context "with empty password confirmation" do
    let(:password_confirmation) { nil }
    it { should_not be_valid }
  end
  
  context "with empty login counter" do
    let(:failed_login_count) { '' }
    it { should_not be_valid }
  end

end
