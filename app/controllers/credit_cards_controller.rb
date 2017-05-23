# frozen_string_literal: true

class CreditCardsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  before_action :set_credit_card, only: %i(show destroy)
  before_action :set_user
  before_action :auth_credit_card

  def index
    @credit_cards = Stripe::Customer.retrieve(
      @user.stripe_customer_token
    ).sources.all(object: "card")
  end

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = @user.credit_cards.new

    if @credit_card.save_card(params[:stripe_card_token])
      redirect_to user_credit_cards_url(@user),
                  notice: "Credit card was successfully added."
    else
      render :new
    end
  end

  def destroy
    @credit_card.destroy_card

    redirect_to user_credit_cards_url(@user),
                notice: "Credit card was successfully destroyed."
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def auth_credit_card
    return if @user == current_user

    redirect_to store_url, notice: "You're not authorized to view this page"
  end
end
