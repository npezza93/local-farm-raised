class CreditCardsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  before_action :set_credit_card, only: [:show, :destroy]
  before_action :set_user
  before_filter :auth_credit_card

  # GET /credit_cards
  # GET /credit_cards.json
  def index
    @credit_cards = @user.credit_cards
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # POST /credit_cards
  # POST /credit_cards.json
  def create
    @credit_card = @user.credit_cards.new

    respond_to do |format|
      if @credit_card.save_card(params[:stripe_card_token])
        format.html { redirect_to user_credit_cards_url(@user), notice: 'Credit card was successfully added.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.json
  def destroy
    @credit_card.destroy_card
    respond_to do |format|
      format.html { redirect_to user_credit_cards_url(@user), notice: 'Credit card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def auth_credit_card
      unless @user = current_user
        redirect_to store_url, notice: "You're not authorized to view this page"
      end
    end
end
