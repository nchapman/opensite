class PagesController < ApplicationController
  before_filter :get_site_by_host
  
  def show
    page = Page.find_by_url!(params[:path], @site)

    template = @site.templates.all.first
    
    render :text => Parser.new(@site).parse_with_template(page, template)
  end
end
