class Admin::ImagesController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  layout "site"
  
  # GET /admin/sites/1/images
  # GET /admin/sites/1/images.xml
  def index
    @images = @site.images.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /admin/sites/1/images/1
  # GET /admin/sites/1/images/1.xml
  def show
    @image = @site.images.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/sites/1/images/new
  # GET /admin/sites/1/images/new.xml
  def new
    @image = @site.images.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/sites/1/images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /admin/sites/1/images
  # POST /admin/sites/1/images.xml
  def create
    @image = @site.images.new(params[:image])
    @image.created_by = @image.updated_by = current_user

    respond_to do |format|
      if @image.save
        flash[:notice] = "Image was successfully created."
        format.html { redirect_to([:admin, @site, @image]) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/images/1
  # PUT /admin/sites/1/images/1.xml
  def update
    @image = @site.images.find(params[:id])
    @image.updated_by = current_user

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = "Image was successfully updated."
        format.html { redirect_to([:admin, @site, @image]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/images/1
  # DELETE /admin/sites/1/images/1.xml
  def destroy
    @image = @site.images.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_images_url(@site)) }
      format.xml  { head :ok }
    end
  end
end
