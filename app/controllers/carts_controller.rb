# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i(show edit update destroy)
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
  end

  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: "Cart was successfully created."
    else
      render :new
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    redirect_to store_url, notice: "Your cart is currently empty."
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params[:cart]
  end

  def invalid_cart
    redirect_to root_url, notice: "Invalid cart"
  end
end
