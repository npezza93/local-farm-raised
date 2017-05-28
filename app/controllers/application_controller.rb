# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cart
    @current_cart ||= Cart.find_or_create_by_session(session)
    session[:cart_id] ||= @current_cart.id

    @current_cart
  end
  helper_method :current_cart

  private

  def auth_admin
    return if current_user&.admin?

    redirect_to store_url, notice: "You are not authorized to view this page"
  end
end
