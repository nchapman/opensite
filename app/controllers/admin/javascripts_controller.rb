class Admin::JavascriptsController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  
  # GET /admin/sites/1/javascripts
  # GET /admin/sites/1/javascripts.xml
  def index
    @javascripts = @site.javascripts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @javascripts }
    end
  end

  # GET /admin/sites/1/javascripts/1
  # GET /admin/sites/1/javascripts/1.xml
  def show
    @javascript = @site.javascripts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @javascript }
    end
  end

  # GET /admin/sites/1/javascripts/new
  # GET /admin/sites/1/javascripts/new.xml
  def new
    @javascript = @site.javascripts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @javascript }
    end
  end

  # GET /admin/sites/1/javascripts/1/edit
  def edit
    @javascript = @site.javascripts.find(params[:id])
  end

  # POST /admin/sites/1/javascripts
  # POST /admin/sites/1/javascripts.xml
  def create
    @javascript = @site.javascripts.new(params[:javascript])

    respond_to do |format|
      if @javascript.save
        flash[:notice] = "Javascript was successfully created."
        format.html { redirect_to([:admin, @site, @javascript]) }
        format.xml  { render :xml => @javascript, :status => :created, :location => @javascript }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @javascript.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/javascripts/1
  # PUT /admin/sites/1/javascripts/1.xml
  def update
    @javascript = @site.javascripts.find(params[:id])

    respond_to do |format|
      if @javascript.update_attributes(params[:javascript])
        flash[:notice] = "Javascript was successfully updated."
        format.html { redirect_to([:admin, @site, @javascript]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @javascript.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/javascripts/1
  # DELETE /admin/sites/1/javascripts/1.xml
  def destroy
    @javascript = @site.javascripts.find(params[:id])
    @javascript.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_javascripts_url(@site)) }
      format.xml  { head :ok }
    end
  end
end
