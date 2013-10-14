class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:secret])
    login_user!(@user)
    redirect_to user_url(@user)
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render :new
  end
end
