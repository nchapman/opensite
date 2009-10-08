class TextualAsset < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :name, :content_type
end
