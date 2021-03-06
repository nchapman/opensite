require "radius"

class Parser
  def initialize(site)
    @context = Radius::Context.new
    
    @context.globals.site = site
    @context.globals.parser = self
    
    [Page, PagePart, StyleSheet, Javascript, Image, Snippet].each do |o|
      o.prepare_global_context(@context)
    end
  end
  
  def parse_with_template(object, template)
    site = template.site
    
    site.prepare_context(@context)
    template.prepare_context(@context)
    object.prepare_context(@context)
    
    parse_text(template.content)
  end
  
  def parse_text(text)
    Radius::Parser.new(@context, :tag_prefix => "os").parse(text) if text
  end
end

class Radius::TagBinding
  def parse(text)
    self.globals.parser.parse_text(text)
  end
end
