class Javascript < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
    self.content_type = "text/javascript"
  end
  
  def self.prepare_global_context(context)
    context.define_tag "javascript" do |tag|
      tag.expand
    end
    
    context.define_tag "javascript:path" do |tag|
      "/assets/javascripts/#{tag.attr["slug"]}.css"
    end
    
    context.define_tag "javascript:link" do |tag|
      "<script src=\"/assets/javascripts/#{tag.attr["slug"]}.js\"></script>"
    end
  end
end
