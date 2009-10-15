class Admin::SnippetsController < ApplicationController
  before_filter :require_user
  before_filter :get_site
  layout "site"
  
  # GET /admin/sites/1/snippets
  # GET /admin/sites/1/snippets.xml
  def index
    @snippets = @site.snippets.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snippets }
    end
  end

  # GET /admin/sites/1/snippets/1
  # GET /admin/sites/1/snippets/1.xml
  def show
    @snippet = @site.snippets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

  # GET /admin/sites/1/snippets/new
  # GET /admin/sites/1/snippets/new.xml
  def new
    @snippet = @site.snippets.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

  # GET /admin/sites/1/snippets/1/edit
  def edit
    @snippet = @site.snippets.find(params[:id])
  end

  # POST /admin/sites/1/snippets
  # POST /admin/sites/1/snippets.xml
  def create
    @snippet = @site.snippets.new(params[:snippet])

    respond_to do |format|
      if @snippet.save
        flash[:notice] = "Snippet was successfully created."
        format.html { redirect_to([:admin, @site, @snippet]) }
        format.xml  { render :xml => @snippet, :status => :created, :location => @snippet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sites/1/snippets/1
  # PUT /admin/sites/1/snippets/1.xml
  def update
    @snippet = @site.snippets.find(params[:id])

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        flash[:notice] = "Snippet was successfully updated."
        format.html { redirect_to([:admin, @site, @snippet]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @snippet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1/snippets/1
  # DELETE /admin/sites/1/snippets/1.xml
  def destroy
    @snippet = @site.snippets.find(params[:id])
    @snippet.destroy

    respond_to do |format|
      format.html { redirect_to(admin_site_snippets_url(@site)) }
      format.xml  { head :ok }
    end
  end
end
