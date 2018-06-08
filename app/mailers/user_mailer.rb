class UserMailer < ActionMailer::Base
  default from: "no-reply@local.com"

  def confirm_registration(user)
    @user = user
    mail(to: @user.email, subject: "Confirm your email")
  end
end