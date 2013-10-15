class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def welcome_email(user)
    @user = user
    @token = @user.activation_token
#    @url = "http://localhost:3000/users/activate?activation_token=#{@token}&email=#{@user.email}"

    @url = "#{activate_user_url(user.id)}?activation_token=#{@token}"
    mail(to: user.email, subject: "Welcome to Music App")
  end

end
