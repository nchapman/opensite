class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :logged_in?, :admin?
  
  protected
    def get_site
      @site = current_user.sites.find(params[:site_id])
    end
    
    def get_site_by_host
      @site = Site.find_by_domain!(request.host)
    end
    
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page."
        redirect_to login_url
        return false
      end
    end
    
    def require_admin
      require_user
      unless current_user.admin?
        flash[:error] = "Access denied."
        redirect_to admin_dashboard_url
      end
    end
    
    def logged_in?
      current_user != nil
    end
    
    def admin?
      logged_in? && current_user.admin?
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page."
        redirect_to admin_dashboard_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
