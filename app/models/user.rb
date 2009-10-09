class User < ActiveRecord::Base
  has_many :memberships
  has_many :sites, :through => :memberships
  
  acts_as_authentic
  
  validates_presence_of :first_name, :last_name
end
