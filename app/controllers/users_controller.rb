class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login_user!(@user)
      mail = UserMailer.welcome_email(@user)
      mail.deliver!
      redirect_to bands_url
    else
      flash[:errors] ||= []
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

end
