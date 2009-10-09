class PagePart < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :name
  
    def self.prepare_global_context(context)    
    context.define_tag "content" do |tag|
      page = tag.locals.page || tag.globals.page
      
      if page
        part = page.parts.find_by_name(tag.attr["part"])
        tag.globals.parser.parse_text(part.body) if part
      end
    end
  end
end
