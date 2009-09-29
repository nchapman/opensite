class Person < ActiveRecord::Base
  
  attr_reader :password
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
  validates_uniqueness_of :email
  validates_confirmation_of :password
  
  def password=(password)
    @password = password
  end
  
end
