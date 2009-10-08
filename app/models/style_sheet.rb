class StyleSheet < TextualAsset
  belongs_to :site
  
  before_validation :set_content_type
  
  def set_content_type
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
      "<script src=\"/assets/style_sheets/#{tag.attr["slug"]}.js\"></script>"
    end

    context.define_tag "style_sheet:inline" do |tag|
      slug = tag.attr["slug"]
      style_sheet = tag.globals.site.style_sheets.find_by_slug(slug)

      <<-CONTENT
<style type="text/css">
#{style_sheet ? style_sheet.body : "/* #{slug} not found. */"}
</style>
CONTENT
    end
  end
end
