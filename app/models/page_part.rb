class PagePart < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :name
  
    def self.prepare_global_context(context)
      # <os:content part="body" />
      context.define_tag "content" do |tag|
        page = tag.locals.page
        part = page.part(tag.attr["part"]) if page
          
        part ? tag.globals.parser.parse_text(part.content) : nil
      end
      
      # <os:if_content part="body"></os:if_content>
      context.define_tag "if_content" do |tag|
        part_name = tag.attr["part"]
        page = tag.locals.page
        
        tag.expand if page && part_name && page.part(part_name) != nil
      end
      
      # <os:unless_content part="body"></os:unless_content>
      context.define_tag "unless_content" do |tag|
        part_name = tag.attr["part"]
        page = tag.locals.page
        
        tag.expand unless page && part_name && page.part(part_name) != nil
      end
  end
end
