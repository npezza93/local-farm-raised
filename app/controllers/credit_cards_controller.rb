# frozen_string_literal: true

class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: :destroy

  def index
    @credit_cards = current_user.credit_cards
  end

  def new
    @credit_card = current_user.credit_cards.new
  end

  def create
    @credit_card = current_user.credit_cards.new

    if @credit_card.save_card(params[:stripe_card_token])
      redirect_to credit_cards_path,
                  notice: "Successfully added card to your wallet"
    else
      render :new
    end
  end

  def destroy
    @credit_card.destroy

    redirect_to credit_cards_path,
                notice: "Successfully removed card to your wallet"
  end

  private

  def set_credit_card
    @credit_card = current_user.credit_cards.find(params[:id])
  end
end
