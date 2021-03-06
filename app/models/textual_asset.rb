class TextualAsset < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  validates_presence_of :name, :content_type, :slug
  validates_uniqueness_of :slug, :scope => [:site_id, :type]
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
end
