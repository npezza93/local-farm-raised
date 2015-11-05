class RegistrationsController < Devise::RegistrationsController
  include CurrentCart
  before_action :set_cart

  protected

  def after_sign_up_path_for(resource)
    settings_url
  end
end
