class Image < BinaryAsset
  validates_attachment_content_type :asset, :content_type => ["image/jpeg", "image/gif", "image/png"]
  
  def url
    "/assets/images/#{self.slug}#{self.asset_extension}"
  end

  def self.prepare_global_context(context)
    context.define_tag "image" do |tag|
      tag.expand
    end
    
    # <os:image:url name="My Image" /> :: /assets/images/my_image.jpg
    context.define_tag "image:url" do |tag|
      name = tag.attr["name"]
      image = tag.globals.site.images.find_by_name(name)
      
      image ? image.url : nil
    end
    
    # <os:image:link name="My Image" /> :: <img src="/assets/images/my_image.jpg" alt="My Image" />
    context.define_tag "image:link" do |tag|
      name = tag.attr["name"]
      image = tag.globals.site.images.find_by_name(name)
      
      puts "########## #{image.inspect}"
      
      image ? "<img src=\"#{image.url}\" alt=\"#{image.name}\" />" : nil
    end
  end
end
