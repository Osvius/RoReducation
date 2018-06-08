class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_admin_user!
    if logged_in? && current_user.admin?
      true
    else
      user_not_authorized
    end
  end

  def current_admin_user
    return nil if logged_in? && !current_user.admin?
    current_user
  end

  private

  def user_not_authorized
    flash[:warning] = "Not enough permissions for this action"
    redirect_to(root_path)
  end
end
