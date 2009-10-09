class Javascript < TextualAsset
  belongs_to :site
  
  def before_validation_on_create
    self.content_type = "text/javascript"
  end
  
  def url
    "/assets/javascripts/#{slug}.js"
  end
  
  def self.prepare_global_context(context)
    context.define_tag "javascript" do |tag|
      tag.expand
    end
    
    # <os:javascript:url name="My Javascript" />
    context.define_tag "javascript:url" do |tag|
      name = tag.attr["name"]
      javascript = tag.globals.site.javascripts.find_by_name(name)
      
      javascript ? javascript.url : nil
    end
    
    # <os:javascript:link name="My Javascript" />
    context.define_tag "javascript:link" do |tag|
      name = tag.attr["name"]
      javascript = tag.globals.site.javascripts.find_by_name(name)
      
      javascript ? "<script src=\"#{javascript.url}\"></script>" : nil
      
    end
  end
end
