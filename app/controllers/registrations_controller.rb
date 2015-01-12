class RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?

    # Insert code to notify admin:
    AdminMailer.new_registration(resource).deliver

    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = update_resource(resource, account_update_params)

    error_flag = false
    if resource.real_name == true
      unless resource.first_name.present? && resource.last_name.present?
        set_flash_message :error, :not_real_name
        resource.real_name = false
        resource.save!
        error_flag = true
      end
    end

    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        unless error_flag == true && flash_key == :updated
          set_flash_message :notice, flash_key
        end
      end
      sign_in resource_name, resource, bypass: true
      if error_flag == true
        redirect_to edit_user_registration_path(resource) and return
      end
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def change_password
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :email_monthly, :first_name, :last_name)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :email_monthly, :first_name, :last_name, :current_password, :real_name)
  end
end
