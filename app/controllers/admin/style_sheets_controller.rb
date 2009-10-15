class Admin::StyleSheetsController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  
  # GET /admin/sites/1/style_sheets
  # GET /admin/sites/1/style_sheets.xml
  def index
    @style_sheets = @site.style_sheets.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @style_sheets }
    end
  end

  # GET /admin/sites/1/style_sheets/1
  # GET /admin/sites/1/style_sheets/1.xml
  def show
    @style_sheet = @site.style_sheets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @style_sheet }
    end
  end

  # GET /admin/sites/1/style_sheets/new
  # GET /admin/sites/1/style_sheets/new.xml
  def new
    @style_sheet = @site.style_sheets.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @style_sheet }
    end
  end

  # GET /admin/sites/1/style_sheets/1/edit
  def edit
    @style_sheet = @site.style_sheets.find(params[:id])
  end

  # POST /admin/sites/1/style_sheets
  # POST /admin/sites/1/style_sheets.xml
  def create
    @style_sheet = @site.style_sheets.new(params[:style_sheet])
    @style_sheet.created_by = @style_sheet.updated_by = current_user

    respond_to do |format|
      if @style_sheet.save
        flash[:notice] = "StyleSheet was successfully created."
        format.html { redirect_to([:admin, @site, @style_sheet]) }
        format.xml  { render :xml => @style_sheet, :status => :created, :location => @style_sheet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @style_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/style_sheets/1
  # PUT /admin/sites/1/style_sheets/1.xml
  def update
    @style_sheet = @site.style_sheets.find(params[:id])
    @style_sheet.updated_by = current_user

    respond_to do |format|
      if @style_sheet.update_attributes(params[:style_sheet])
        flash[:notice] = "StyleSheet was successfully updated."
        format.html { redirect_to([:admin, @site, @style_sheet]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @style_sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/style_sheets/1
  # DELETE /admin/sites/1/style_sheets/1.xml
  def destroy
    @style_sheet = @site.style_sheets.find(params[:id])
    @style_sheet.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_style_sheets_url(@site)) }
      format.xml  { head :ok }
    end
  end
end
