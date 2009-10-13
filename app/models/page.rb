class Page < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_many :parts, :class_name => "PagePart", :dependent => :destroy
  
  acts_as_nested_set
  
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => [:site_id]
  validates_uniqueness_of :slug, :scope => [:site_id]
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
  
  accepts_nested_attributes_for :parts, :allow_destroy => true, :reject_if => proc { |p| p["name"].blank? && ["content"].blank? }
  
  def self.find_by_url(url, site)
    # Normalize incoming URL
    url = "/" if url.nil?
    url = url.join("/") if url.instance_of?(Array)
    url = "/#{url}/".gsub(/\/{2,}/, "/")
    url_parts = url.gsub(/(^\/+)|(\/+$)/, "").split("/")

    if url_parts.empty?
      return site.pages.find_by_home(true)
    else
      pages = Page.find(:all, :conditions => {:slug => url_parts[-1], :site_id => site.id})
      
      pages.each do |page|
        return page if page.url == url
      end
    end
    
    return nil
  end
  
  def self.find_by_url!(url, site)
    if page = Page.find_by_url(url, site)
      return page
    else
      raise "Page not found."
    end
  end
  
  def cache_key
    "page:#{self.id}"
  end
  
  def url
    to_return = "/"
    
    if self.home?
      return to_return
    else
      self.ancestors.each {|a| to_return << a.slug << "/"} unless self.root?
      return to_return << self.slug << "/"
    end
  end
  
  def part(name)
    if new_record? || parts.to_a.any?(&:new_record?)
      parts.to_a.find {|p| p.name == name.to_s }
    else
      parts.find_by_name(name.to_s)
    end
  end
  
  def self.prepare_global_context(context)
    # <os:title />
    context.define_tag "title" do |tag|
      tag.locals.page.title
    end
    
    # <os:slug />
    context.define_tag "slug" do |tag|
      tag.locals.page.slug
    end
    
    # <os:link /> or <os:link>Text for Link</os:link>
    context.define_tag "link" do |tag|
      page = tag.locals.page
      
      text = tag.double? ? tag.expand : page.title
      
      %Q{<a href="#{page.url}">#{text}</a>}
    end
    
    # <os:find url="/whatever"></os:find>
    context.define_tag "find" do |tag|
      url = tag.attr["url"]
      tag.locals.page = Page.find_by_url(url, tag.globals.site)
      tag.expand
    end
    
    # <os:children></os:children>
    context.define_tag "children" do |tag|
      tag.locals.pages = tag.locals.page.children
      tag.expand
    end
    
    # <os:children:each></os:children:each>
    context.define_tag "children:each" do |tag|
      content = ""
      tag.locals.pages.each do |page|
        tag.locals.page = page
        content << tag.expand
      end
      content
    end
  end
  
  def prepare_context(context)    
    context.globals.page = self
  end
end
