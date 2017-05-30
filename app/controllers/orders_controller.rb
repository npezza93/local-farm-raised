# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :auth_user
  before_action :auth_admin, only: %i(edit update)
  before_action :set_order, only: %i(edit update show destroy)
  before_action :check_cart, only: :new

  def index
    @orders =
      if current_user&.admin?
        Order
      else
        current_user.orders
      end.page(params[:page]).per(30)
  end

  def show
  end

  def new
    @credit_cards = current_user.credit_cards
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)

    if @order.save_with_payment(current_cart)
      session[:cart_id] = nil

      redirect_to store_url, notice: "Your order has been placed"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.fulfill(fulfillment_params)
      redirect_to @order, notice: "Order fulfilled"
    else
      render :edit
    end
  end

  def destroy
    notice =
      if @order.cancel_order
        "Order was successfully canceled and refunded"
      else
        "Order cancellation failed"
      end

    redirect_to @order, notice: notice
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:credit_card_id, :address_id)
  end

  def fulfillment_params
    params.require(:order).permit(:shipping_carrier, :shipping_tracking_number)
  end

  def check_cart
    return if current_cart.line_items.present?

    redirect_to store_url, notice: "Your cart is empty"
  end
end
