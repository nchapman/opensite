class PagesController < ApplicationController
  def show
    @site = Site.find_by_domain!(request.host)
    
    if params[:path].nil?
      @page = @site.pages.find_by_home!(true)
    else
      @page = @site.pages.find_by_slug!(params[:path].first)
    end
    
    @_template = @site.templates.all.first
    render :text => @_template.parse(@page)
  end
end
