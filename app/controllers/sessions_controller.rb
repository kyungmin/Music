class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:secret])
    if @user.activated
      login_user!(@user)
      redirect_to bands_url
    else
      flash[:errors] ||= []
      flash[:errors] << "Account has not been activated yet. Check your email."
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    flash[:notice] ||= []
    flash[:notice] << "Signed out"
    render :new
  end
end
