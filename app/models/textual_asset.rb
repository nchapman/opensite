class TextualAsset < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :name, :content_type, :slug
  validates_uniqueness_of :slug, :scope => [:type, :site_id]
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
end
