class Admin::SitesController < ApplicationController
  before_filter :require_user
  layout "application"
  
  # GET /admin/sites
  # GET /admin/sites.xml
  def index
    @sites = current_user.sites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sites }
    end
  end

  # GET /admin/sites/1
  # GET /admin/sites/1.xml
  def show
    @site = current_user.sites.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /admin/sites/new
  # GET /admin/sites/new.xml
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /admin/sites/1/edit
  def edit
    @site = current_user.sites.find(params[:id])
  end

  # POST /admin/sites
  # POST /admin/sites.xml
  def create
    @site = Site.new(params[:site])
    @site.users << current_user
    
    @site.created_by = @site.updated_by = current_user

    respond_to do |format|
      if @site.save
        flash[:notice] = "Site was successfully created."
        format.html { redirect_to([:admin, @site]) }
        format.xml  { render :xml => @site, :status => :created, :location => @site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1
  # PUT /admin/sites/1.xml
  def update
    @site = current_user.sites.find(params[:id])
    @site.updated_by = current_user

    respond_to do |format|
      if @site.update_attributes(params[:site])
        flash[:notice] = "Site was successfully updated."
        format.html { redirect_to([:admin, @site]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1
  # DELETE /admin/sites/1.xml
  def destroy
    @site = current_user.sites.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sites_url) }
      format.xml  { head :ok }
    end
  end
end
