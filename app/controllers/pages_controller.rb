class PagesController < ApplicationController
  before_filter :get_site_by_host
  
  def show    
    if params[:path].nil?
      page = @site.pages.find_by_home!(true)
    else
      page = Page.find_by_path!(params[:path], @site)
    end
    
    template = @site.templates.all.first
    
    render :text => Parser.new(@site).parse_with_template(page, template)
  end
end
