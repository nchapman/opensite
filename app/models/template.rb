require "radius"

class Template < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  validates_presence_of :title, :body
  
  def self.prepare_global_context(context)
  end
  
  def prepare_context(context)
    context.globals.site = self.site
    context.define_tag "site", :for => self.site, :expose => [:name]
  end
  
  def parse(object)
    context = Radius::Context.new
    
    Template.prepare_global_context(context)
    Page.prepare_global_context(context)
    StyleSheet.prepare_global_context(context)
    Javascript.prepare_global_context(context)
    
    self.prepare_context(context)
    object.prepare_context(context)
    
    return Radius::Parser.new(context, :tag_prefix => "os").parse(self.body)
  end
end
