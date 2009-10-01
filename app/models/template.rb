class Template < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :title, :body
end
