class PagePart < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :name
  
    def self.prepare_global_context(context)
      # <os:content part="body" />
      context.define_tag "content" do |tag|
        page = tag.locals.page || tag.globals.page
        part = page.part(tag.attr["part"]) if page
          
        part ? tag.globals.parser.parse_text(part.content) : nil
      end
  end
end
