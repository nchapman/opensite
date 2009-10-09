class Snippet < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:site_id]
  
  def self.prepare_global_context(context)
    # <os:snippet name="copyright" />
    context.define_tag "snippet" do |tag|
      snippet = tag.globals.site.snippets.find_by_name(tag.attr["name"])
      
      if snippet
        tag.locals.yield = tag.expand if tag.double?
        tag.globals.parser.parse_text(snippet.content)
      end
    end
    
    context.define_tag "snippet:yield" do |tag|
      tag.locals.yield
    end
  end
end
