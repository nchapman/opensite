class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :memberships
  has_many :sites, :through => :memberships
  
  validates_presence_of :first_name, :last_name
end
