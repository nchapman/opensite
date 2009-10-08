class StyleSheetsController < ApplicationController
  before_filter :get_site_by_host
  
  def show
    @style_sheet = @site.style_sheets.find_by_slug!(params[:slug])
    
    render :text => @style_sheet.body, :content_type => @style_sheet.content_type
  end
end
