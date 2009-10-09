class StyleSheet < TextualAsset
  belongs_to :site
  
  def after_initialize
    self.content_type = "text/css"
  end
  
  def self.prepare_global_context(context)
    context.define_tag "style_sheet" do |tag|
      tag.expand
    end

    context.define_tag "style_sheet:path" do |tag|
      "/assets/style_sheets/#{tag.attr["slug"]}.css"
    end

    context.define_tag "style_sheet:link" do |tag|
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"/assets/style_sheets/#{tag.attr["slug"]}.css\"/>"
    end
  end
end
