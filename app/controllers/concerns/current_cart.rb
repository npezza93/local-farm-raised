# frozen_string_literal: true

module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
    @cart ||= Cart.create
    session[:cart_id] = @cart.id
  end
end
