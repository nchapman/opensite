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
    
    context.define_tag "javascript:inline" do |tag|
      slug = tag.attr["slug"]
      javascript = tag.globals.site.javascripts.find_by_slug(slug)
      
      <<-CONTENT
<script type="text/javascript">
#{javascript ? javascript.body : "// #{slug} not found."}
</script>
CONTENT
    end
  end
end
