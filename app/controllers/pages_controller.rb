class PagesController < ApplicationController
  def show
    @site = Site.find_by_subdomain!(request.subdomains.first)
    @page = @site.pages.find_by_slug!(params[:id])
    @_template = @site.templates.all.first
    render :text => @_template.parse(@page)
  end
end
