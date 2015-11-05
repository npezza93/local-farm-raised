class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:new, :create]
  before_filter :sign_in_if_not, only: :new
  before_filter :authenticate_user

  # GET /orders
  # GET /orders.json
  def index
    if current_user.try(:admin?)
      @orders = Order.search(params[:search]).paginate(:page => params[:page], per_page: 30)
    else
      @orders = current_user.orders.search(params[:search]).paginate(:page => params[:page], per_page: 30)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save_with_payment
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to store_url, notice: 'Your order has been placed.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    respond_to do |format|
      if @order.cancel_order
        format.html { redirect_to orders_url, notice: 'Order was successfully canceled and refunded.' }
        format.json { head :no_content }
      else
        format.html { redirect_to order_url(@order), notice: "Charge has already been refunded." }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:credit_card_id, :address_id, :user_id)
    end

    def sign_in_if_not
      if !user_signed_in?
        redirect_to new_user_session_url
      end
    end

    def authenticate_user
      if !user_signed_in?
        redirect_to root_url, notice: "You're not authorized to view this page"
      end
    end
end
