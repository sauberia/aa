class UserSessionsController < ApplicationController

  before_filter :require_user,    :only => :destroy
  before_filter :require_no_user, :only => [:new, :create]



  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = 'Login successful!'
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def destroy
    logout if current_user
    flash[:notice] = 'Logout successful!'
    redirect_to login_url
  end



  private

    def require_no_user
      if current_user
        redirect_to root_url
        return false
      end
    end

end