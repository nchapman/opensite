class PagesController < ApplicationController
  before_filter :get_site_by_host
  
  def show    
    if params[:path].nil?
      page = @site.pages.find_by_home!(true)
    else
      page = @site.pages.find_by_slug!(params[:path].first)
    end
    
    template = @site.templates.all.first
    
    render :text => Parser.new(@site).parse_with_template(page, template)
  end
end
