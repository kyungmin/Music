class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      mail = UserMailer.welcome_email(@user)
      mail.deliver!
      flash[:notice] ||= []
      flash[:notice] << "Please check your email to activate your account."
      redirect_to new_session_url
    else
      flash[:errors] ||= []
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find(params[:id])
    if @user.activation_token == params[:activation_token]
      @user.activated = true
      @user.save!
      flash[:notice] ||= []
      flash[:notice] << "Activated your account."
      login_user!(@user)
      redirect_to bands_url
    else
      flash[:errors] ||= []
      flash[:errors] << "Oops, you came from a wrong path!"
      redirect_to new_user_url
    end
  end

end
