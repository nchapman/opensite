require 'digest/sha2'

class Person < ActiveRecord::Base
  
  attr_reader :password
  
  validates_presence_of :first_name, :last_name, :email
  
  validates_format_of :email, :with => /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :email
  
  validates_format_of :password, :with => /^([\x20-\x7E]){5,}$/, :message => "must be at least 5 characters", :unless => :password_is_not_being_updated?
  validates_confirmation_of :password
  
  after_save :flush_passwords
  
  def password=(password)
    @password = password
    
    unless password_is_not_being_updated?
      self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
      self.encrypted_password = Digest::SHA256.hexdigest(password + self.salt)
    end
  end
  
  def self.authenticate(email, password)
    person = self.find_by_email(email)
    if person and person.encrypted_password and person.encrypted_password == Digest::SHA256.hexdigest(password + person.salt)
      return person
    else
      return nil
    end
  end
  
  private
  
  def password_is_not_being_updated?
    self.id and self.password.blank?
  end
  
  def flush_passwords
    @password = @password_confirmation = nil
  end
  
end
