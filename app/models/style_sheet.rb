class StyleSheet < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
    self.content_type = "text/css"
  end
  
  def self.prepare_global_context(context)
    context.with do |c|
      c.define_tag "style_sheet" do |tag|
        if tag.attr["name"]
          tag.locals.style_sheet = tag.globals.site.style_sheets.find_by_name!(tag.attr["name"])
        else
          tag.locals.style_sheet = tag.globals.site.style_sheets.find_by_slug!(tag.attr["slug"])
        end
        
        tag.expand
      end
      c.define_tag "style_sheet:path" do |tag|
        "/assets/style_sheets/#{tag.locals.style_sheet.slug}.css"
      end
      c.define_tag "style_sheet:link" do |tag|
        "<link rel=\"stylesheet\" type=\"text/css\" href=\"/assets/style_sheets/#{tag.locals.style_sheet.slug}.css\" />"
      end
    end
  end
end
