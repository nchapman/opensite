class Admin::PagesController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  
  # GET /admin/sites/1/pages
  # GET /admin/sites/1/pages.xml
  def index
    @pages = @site.pages.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /admin/sites/1/pages/1
  # GET /admin/sites/1/pages/1.xml
  def show
    @page = @site.pages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin/sites/1/pages/new
  # GET /admin/sites/1/pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin/sites/1/pages/1/edit
  def edit
    @page = @site.pages.find(params[:id])
  end

  # POST /admin/sites/1/pages
  # POST /admin/sites/1/pages.xml
  def create
    @page = @site.pages.new(params[:page])
    @page.created_by = @page.updated_by = current_user

    respond_to do |format|
      if @page.save
        flash[:notice] = "Page was successfully created."
        format.html { redirect_to([:admin, @site, @page]) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/pages/1
  # PUT /admin/sites/1/pages/1.xml
  def update
    @page = @site.pages.find(params[:id])
    @page.updated_by = current_user

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = "Page was successfully updated."
        format.html { redirect_to([:admin, @site, @page]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/pages/1
  # DELETE /admin/sites/1/pages/1.xml
  def destroy
    @page = @site.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_pages_url(@site)) }
      format.xml  { head :ok }
    end
  end
end
