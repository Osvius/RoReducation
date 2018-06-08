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

  def change_password

  end

  def update_password
    if @user.update_with_context(user_update_pass_params, :password_change)
      flash[:success] = "Password changed successfully"
      redirect_to profile_path
    else
      render 'change_password'
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end

  def user_update_pass_params
    params.require(:user).permit(:password, :password_confirmation, :old_password)
  end

  def set_user
    @user = current_user
  end
end