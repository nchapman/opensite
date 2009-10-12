class PagePart < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :name
  
  def self.prepare_global_context(context)
    # <os:content part="body" />
    context.define_tag "content" do |tag|
      part = tag.get_part
      
      part ? tag.parse(part.content) : nil
    end
    
    # <os:if_content part="body"></os:if_content>
    context.define_tag "if_content" do |tag|
      tag.expand if get_part
    end
    
    # <os:unless_content part="body"></os:unless_content>
    context.define_tag "unless_content" do |tag|
      tag.expand unless get_part
    end
  end
end

class Radius::TagBinding
  def get_part()
    part_name = self.attr["part"] || "body"
    inherit = self.attr["inherit"] == "true" ? true : false
    
    page = self.locals.page
    part = page.part(part_name)
    
    if inherit && part.nil? && !page.ancestors.empty?
      page.ancestors.reverse.each do |a|
        part = a.part(part_name)
        break if part
      end
    end
    
    return part
  end
end
