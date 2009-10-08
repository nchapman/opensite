class ImagesController < ApplicationController
  before_filter :get_site_by_host
  
  def show
    @image = @site.images.find_by_slug!(params[:slug])
    
    send_file(@image.asset.path, :type => @image.asset.content_type, :disposition => "inline")
  end
end
