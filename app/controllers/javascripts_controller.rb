class JavascriptsController < ApplicationController
  def show
    content = Cache.get(request.url)
    
    unless content
      get_site_by_host
      
      javascript = @site.javascripts.find_by_slug!(params[:slug])
      
      content = Parser.new(@site).parse_text(javascript.content)
      
      @cache.add(request.url, content)
    end
    
    render :text => content, :content_type => "text/javascript"
  end
end
