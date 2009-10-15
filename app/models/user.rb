class User < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_many :memberships
  has_many :sites, :through => :memberships
  
  acts_as_authentic
  
  validates_presence_of :first_name, :last_name
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
