class Image < BinaryAsset
  def self.prepare_global_context(context)
    context.define_tag "image" do |tag|
      tag.expand
    end
    
    context.define_tag "image:path" do |tag|
      slug = tag.attr["slug"]
      image = tag.globals.site.images.find_by_slug(slug)
      
      "/assets/images/#{image.slug}#{image.asset_extension}"
    end
    
    context.define_tag "image:link" do |tag|
      slug = tag.attr["slug"]
      image = tag.globals.site.images.find_by_slug(slug)
      
      "<img src=\"/assets/images/#{image.slug}#{image.asset_extension}\" alt=\"#{image.name}\" />"
    end
  end
end
