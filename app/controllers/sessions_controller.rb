class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email]
    if user&.verified
        if user.authenticate(params[:session][:password])
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_to profile_url
        else
          flash.now[:error] = "Invalid email/password combination"
          render 'new'
        end
    else
      flash.now[:error] = "Your email is not found or not confirmed"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
