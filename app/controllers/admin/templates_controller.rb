class Admin::TemplatesController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  layout "site"
  
  # GET /admin/sites/1/templates
  # GET /admin/sites/1/templates.xml
  def index
    @_templates = @site.templates.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @_templates }
    end
  end

  # GET /admin/sites/1/templates/1
  # GET /admin/sites/1/templates/1.xml
  def show
    @_template = @site.templates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @_template }
    end
  end

  # GET /admin/sites/1/templates/new
  # GET /admin/sites/1/templates/new.xml
  def new
    @_template = @site.templates.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @_template }
    end
  end

  # GET /admin/sites/1/templates/1/edit
  def edit
    @_template = @site.templates.find(params[:id])
  end

  # POST /admin/sites/1/templates
  # POST /admin/sites/1/templates.xml
  def create
    @_template = @site.templates.new(params[:template])
    @_template.created_by = @_template.updated_by = current_user

    respond_to do |format|
      if @_template.save
        flash[:notice] = "Template was successfully created."
        format.html { redirect_to([:admin, @site, @_template]) }
        format.xml  { render :xml => @_template, :status => :created, :location => @_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/templates/1
  # PUT /admin/sites/1/templates/1.xml
  def update
    @_template = @site.templates.find(params[:id])
    @_template.updated_by = current_user

    respond_to do |format|
      if @_template.update_attributes(params[:template])
        flash[:notice] = "Template was successfully updated."
        format.html { redirect_to([:admin, @site, @_template]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/templates/1
  # DELETE /admin/sites/1/templates/1.xml
  def destroy
    @_template = @site.templates.find(params[:id])
    @_template.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_templates_url) }
      format.xml  { head :ok }
    end
  end
end
