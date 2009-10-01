class Page < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :title
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
end
