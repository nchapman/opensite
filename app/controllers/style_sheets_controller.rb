class StyleSheetsController < ApplicationController
  def show
    content = Cache.get(request.url)
    
    unless content
      get_site_by_host
      
      style_sheet = @site.style_sheets.find_by_slug!(params[:slug])
      
      content = Parser.new(@site).parse_text(style_sheet.content)
      
      @cache.add(request.url, content)
    end
    
    render :text => content, :content_type => "text/css"
  end
end
