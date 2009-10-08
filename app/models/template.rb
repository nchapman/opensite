require "radius"

class Template < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  validates_presence_of :title, :body
  
  def self.prepare_global_context(context)
    [Page, StyleSheet, Javascript, Image].each do |o|
      o.prepare_global_context(context)
    end
  end
  
  def prepare_context(context)
    context.globals.site = self.site
    context.globals.template = self
    context.define_tag "site", :for => self.site, :expose => [:name]
  end
  
  def parse(object)
    @context = Radius::Context.new
    
    Template.prepare_global_context(@context)
    
    self.prepare_context(@context)
    object.prepare_context(@context)
    
    return parse_text(self.body)
  end
  
  def parse_text(text)
    Radius::Parser.new(@context, :tag_prefix => "os").parse(text)
  end
end
