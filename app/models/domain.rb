class Domain < ActiveRecord::Base
  belongs_to :site
  
  validates_uniqueness_of :fqdn, :message => "is already taken"
end
