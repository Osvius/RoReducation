class UsersController < ApplicationController

  def index
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirm_registration(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      redirect_to welcome_index_url
    else
      render 'new'
    end
  end

  def confirm_registration
    user = User.find_by_verify_token(params[:token])
    if user
      user.email_verify
      flash[:success] = "Email confirmed successfully"
      log_in user
      redirect_to users_path
    else
      flash[:error]= "User doen't exist"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end