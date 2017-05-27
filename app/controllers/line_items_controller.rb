# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i(show edit update destroy)

  def create
    product = Product.find(line_item_params[:product_id])
    @line_item = @cart.add_product(product.id, line_item_params[:quantity])

    respond_to do |format|
      if @line_item.save
        format.js
      else
        format.js { @errors = true}
      end
    end
  end

  def update
    return detroy if line_item_params["quantity"].to_i.zero?

    respond_to do |format|
      if @line_item.update(line_item_params)
        format.js
      else
        format.js { @errors = true}
      end
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
end
