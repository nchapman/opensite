class BinaryAsset < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  has_attached_file :asset, :styles => { :thumb => "100x100>" }
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug, :scope => [:type, :site_id]
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
  
  def asset_extension
    File.extname(asset.original_filename)
  end
end
