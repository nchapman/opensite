class JavascriptsController < ApplicationController
  before_filter :get_site_by_host
  
  def show
    javascript = @site.javascripts.find_by_slug!(params[:slug])
    parser = Parser.new(@site)
    
    render :text => parser.parse_text(javascript.body), :content_type => javascript.content_type
  end
end
