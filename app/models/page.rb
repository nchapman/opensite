class Page < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  validates_presence_of :title
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
  
  def self.prepare_global_context(context)
    # This is only an example
      context.define_tag "pages" do |tag|
        tag.locals.pages = tag.globals.site.pages.all
        tag.expand
      end
      context.define_tag "pages:each" do |tag|
        content = ""
        tag.locals.pages.each do |page|
          tag.locals.page = page
          content << tag.expand
        end
        content
      end
      context.define_tag "pages:each:title" do |tag|
        tag.locals.page.title
      end
  end
  
  def prepare_context(context)    
    context.globals.page = self
    
    context.define_tag "title" do |tag|
      tag.globals.page.title
    end
    
    context.define_tag "body" do |tag|
      tag.globals.parser.parse_text(tag.globals.page.body)
    end
  end
end
