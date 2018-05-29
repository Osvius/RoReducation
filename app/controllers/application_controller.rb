class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def user_not_authorized
    flash[:warning] = "Not enough permissions for this action"
    redirect_to(request.referrer || root_path)
  end
end
