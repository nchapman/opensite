class Page < ActiveRecord::Base
  belongs_to :site
  
  validates_presence_of :title
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
  
  def self.prepare_global_context(context)
    # This is only an example
    context.with do |c|
      c.define_tag "pages" do |tag|
        tag.expand
      end
      c.define_tag "pages:each" do |tag|
        content = ""
        Page.all.each do |page|
          tag.locals.page = page
          content << tag.expand
        end
        content
      end
      c.define_tag "pages:each:title" do |tag|
        tag.locals.page.title
      end
    end
  end
  
  def prepare_context(context)
    context.define_tag "page", :for => self, :expose => [ :title, :body, :slug ]
  end
end
