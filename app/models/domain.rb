class Domain < ActiveRecord::Base
  belongs_to :site
  
  validates_uniqueness_of :fqdn, :message => "is already taken"
  validates_format_of :fqdn, :with => /^[a-z0-9\-\.]+$/, :message => "can only contain lowercase letters, numbers, dashes, and periods"
end
