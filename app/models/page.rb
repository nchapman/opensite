class Page < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_many :parts, :class_name => "PagePart", :dependent => :destroy
  
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => [:site_id]
  validates_uniqueness_of :slug, :scope => [:site_id]
  validates_format_of :slug, :with => /^[a-z0-9_]+$/, :message => "can only contain lowercase letters, numbers, and underscores"
  
  accepts_nested_attributes_for :parts, :allow_destroy => true, :reject_if => proc { |p| p["name"].blank? && ["content"].blank? }
  
  def after_initialize
    parts << PagePart.new(:name => "body") if new_record?
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
