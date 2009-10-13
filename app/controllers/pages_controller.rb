class PagesController < ApplicationController
  def show
    content = cache_get_by_url
    
    unless content
      get_site_by_host
      
      page = Page.find_by_url!(params[:path], @site)

      template = @site.templates.all.first
      
      content = Parser.new(@site).parse_with_template(page, template)
      
      cache_add(page.cache_key, content)
    end
    
    render :text => content
  end
end
