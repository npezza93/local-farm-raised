class RegistrationsController < Devise::RegistrationsController
  include CurrentCart
  before_action :set_cart

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
