class Admin::DashboardController < ApplicationController
  before_filter :require_user
  
  def index
    @sites = current_user.sites
  end
end
