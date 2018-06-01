class ProfileController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_update_params)
      flash[:success] = "Saved successfully"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end

  def set_user
    @user = current_user
  end
end