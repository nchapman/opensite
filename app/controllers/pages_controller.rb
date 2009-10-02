class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
    @_template = Template.all.first
    render :text => @_template.parse(@page)
  end
end
