class PagesController < ApplicationController
  def show
    content = Cache.get_by_url(request.url)
    
    unless content
      get_site_by_host
      
      page = Page.find_by_url!(params[:path], @site)

      template = @site.templates.all.first
      
      content = Parser.new(@site).parse_with_template(page, template)
      
      Cache.add(page.cache_key, request.url, content)
    end
    
    render :text => content
  end
end
