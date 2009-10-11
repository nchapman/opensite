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
  
  def self.find_by_path(path, site)
    path_parts = path

    if path_parts.size == 1
      return Page.find_by_slug_and_site_id(path_parts.first, site.id)
    else
      # would this be better as a series of self joins?
      # mysql might perform better this way rather than a large join
      
      pages = Page.find_all_by_slug_and_site_id(path_parts.pop, site.id)

      pages.each do |p|
        p.ancestors.each_index do |i|
          a = p.ancestors[i]
          return p if path_parts.size == i + 1 && a.slug == path_parts[i]
          break if a.slug != path_parts[i]
        end
      end
    end
    
    return nil
  end
  
  def self.find_by_path!(path, site)
    page = Page.find_by_path(path, site)
    
    if page
      return page
    else
      raise "Page not found."
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
  end
  
  def prepare_context(context)    
    context.globals.page = self
    
    # <os:title />
    context.define_tag "title" do |tag|
      tag.globals.page.title
    end
    
    # <os:body />
    context.define_tag "body" do |tag|
      page = tag.globals.page
      part = page.part(:body)
      part ? tag.globals.parser.parse_text(part.content) : nil
    end
  end
end
