class Javascript < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
    self.content_type = "text/javascript"
  end
end