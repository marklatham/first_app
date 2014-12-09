class RegistrationsController < Devise::RegistrationsController
 
  private
 
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :email_monthly, :first_name, :last_name)
  end
 
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :email_monthly, :first_name, :last_name, :current_password)
  end
end
