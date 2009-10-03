class Site < ActiveRecord::Base
  has_many :pages
  has_many :templates
  has_many :memberships
  has_many :users, :through => :memberships
  
  validates_presence_of :name
  validates_format_of :subdomain, :with => /^[a-z0-9]+$/, :on => :create, :message => "can only contain lowercase letters and numbers"
  validates_uniqueness_of :subdomain, :message => "is already taken"
end
