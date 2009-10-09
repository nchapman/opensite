class Template < ActiveRecord::Base
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  
  validates_presence_of :title, :body
  
  def prepare_context(context)
    context.globals.template = self
  end
end
