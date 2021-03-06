class Admin::PagesController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  before_filter :get_parent_page
  before_filter :get_templates
  layout "site"
  
  # GET /admin/sites/1/pages
  # GET /admin/sites/1/pages.xml
  def index
    @pages = @parent_page.children

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
    @page = @site.pages.new
    @page.parts << PagePart.new(:name => "body")

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
    @page = @parent_page.children.new(params[:page])
    
    @page.site = @site
    @page.created_by = @page.updated_by = current_user

    respond_to do |format|
      if @page.save
        flash[:notice] = "Page was successfully created."
        format.html { redirect_to(@parent_page ? admin_site_page_child_path(@site, @parent_page, @page) : admin_site_page_path(@site, @page))}
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
        format.html { redirect_to(@parent_page ? admin_site_page_child_path(@site, @parent_page, @page) : admin_site_page_path(@site, @page)) }
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
      format.html { redirect_to(@parent_page ? admin_site_page_children_url(@site, @parent_page) : admin_site_pages_url(@site)) }
      format.xml  { head :ok }
    end
  end
  
  private
    def get_parent_page
      @parent_page = params.include?(:page_id) ? @site.pages.find(params[:page_id]) : @site.pages.root
    end
    
    def get_templates
      @templates = @site.templates.all
    end
end
