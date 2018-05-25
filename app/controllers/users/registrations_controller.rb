class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :change_password]

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute], except: [:password])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def change_password
    render :change_password
  end

  def update_password
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)


    resource_updated = update_user_password(resource, password_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
                        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :change_password
    end
  end

  protected

  def password_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def update_user_password(resource, params)
    resource.update_with_password(params)
  end

end
