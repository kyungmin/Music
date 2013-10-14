class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:email], params[:secret])
    login_user!(@user)
    render :show
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render :new
  end
end
