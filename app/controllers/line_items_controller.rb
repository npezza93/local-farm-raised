# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: :update

  def create
    @line_item = current_cart.add_product(product_id)

    redirect_to store_path,
                notice: "#{@line_item.product.title} added to your cart"
  end

  def update
    if quantity.zero? || quantity.negative?
      @line_item.destroy
    else
      @line_item.update(quantity: quantity)
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def quantity
    params.dig(:line_item, :quantity).to_i
  end

  def product_id
    params.dig(:line_item, :product_id)
  end
end
