class UsersController < ApplicationController
  attr_reader :user, :users
  before_action :authenticate_user!, :get_current_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_url
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :surname)
  end

  def get_current_user
    @user = current_user
  end
end