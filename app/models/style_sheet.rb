class StyleSheet < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
    self.content_type = "text/css"
  end
end
