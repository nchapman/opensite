class Javascript < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
    self.content_type = "text/javascript"
  end
  
  def self.prepare_global_context(context)
    context.with do |c|
      c.define_tag "javascript" do |tag|
        if tag.attr["name"]
          tag.locals.javascript = tag.globals.site.javascripts.find_by_name!(tag.attr["name"])
        else
          tag.locals.javascript = tag.globals.site.javascripts.find_by_slug!(tag.attr["slug"])
        end
        
        tag.expand
      end
      c.define_tag "javascript:path" do |tag|
        "/assets/javascripts/#{tag.locals.javascript.slug}.css"
      end
      c.define_tag "javascript:link" do |tag|
        "<script src=\"/assets/javascripts/#{tag.locals.javascript.slug}.js\"></script>"
      end
    end
  end
end
