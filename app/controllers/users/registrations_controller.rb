class Users::RegistrationsController < Devise::RegistrationsController

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute], except: [:password])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
