class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_current_user

  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  rescue_from Authorization::NotAuthorized, :with => :redirect_if_not_authorized



  private

    # AUTHENTICATION
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def logout
      current_user_session.destroy
    end

    def require_user
      unless current_user
        flash[:error] = 'You must be logged in to access this page'
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        redirect_to root_url
        return false
      end
    end

    # AUTHORISATION
    def set_current_user
      Authorization.current_user = current_user
    end

    # EXCEPTION HANDLING
    def redirect_if_not_found
      flash[:error] = 'That page does not exist'
      redirect_to root_url
    end

    def redirect_if_not_authorized
      render :text => "You (#{Authorization.current_user.email}) are not authorised to perform that action"
    end

end