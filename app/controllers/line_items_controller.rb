# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i(update destroy)

  def create
    @line_item = current_cart.line_items.create(line_item_params)

    respond_to do |format|
      format.js
    end
  end

  def update
    return detroy if quantity.zero? || quantity.negative?

    respond_to do |format|
      @line_item.update(quantity: quantity)
      format.js
    end
  end

  def destroy
    @line_item.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end

  def quantity
    line_item_params.dig(:quantity).to_i
  end
end
