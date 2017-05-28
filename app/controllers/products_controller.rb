# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i(show edit update destroy)
  before_action :auth_admin, except: %i(index show)

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @line_item = LineItem.new
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy

    redirect_to store_url, notice: "Product was successfully destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :title, :description, :image, :price, :remote_image_url
    )
  end
end
