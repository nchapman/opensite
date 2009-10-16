class PagesController < ApplicationController
  def show
    content = Cache.get(request.url)
    
    unless content
      get_site_by_host
      
      page = Page.find_by_url!(params[:path], @site)

      template = page.get_template
      
      content = Parser.new(@site).parse_with_template(page, template)
      
      @cache.add(request.url, content)
    end
    
    render :text => content
  end
end
