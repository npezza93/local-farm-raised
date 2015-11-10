class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :destroy, :update]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # POST /line_items
  # POST /line_items.json
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

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if line_item_params["quantity"].to_i == 0
          @line_item.destroy
          format.js
      else
        if @line_item.update(line_item_params)
          format.js
        else
          format.js { @errors = true}
        end
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :quantity)
    end
end
