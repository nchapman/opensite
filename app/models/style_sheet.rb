class StyleSheet < TextualAsset
  belongs_to :site
  
  def before_validation_on_create
    self.content_type = "text/css"
  end
  
  def url
    "/assets/style_sheets/#{slug}.css"
  end
  
  def self.prepare_global_context(context)
    context.define_tag "style_sheet" do |tag|
      tag.expand
    end

    context.define_tag "style_sheet:url" do |tag|
      name = tag.attr["name"]
      style_sheet = tag.globals.site.style_sheets.find_by_name(name)
      
      style_sheet ? style_sheet.url : ""
    end

    context.define_tag "style_sheet:link" do |tag|
      name = tag.attr["name"]
      style_sheet = tag.globals.site.style_sheets.find_by_name(name)
      
      style_sheet ? "<link rel=\"stylesheet\" type=\"text/css\" href=\"#{style_sheet.url}\"/>" : ""
    end
  end
end
