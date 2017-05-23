# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]
  before_action :set_user

  def index
    @subscriptions = Subscription.all
  end

  def new
    @subscription = Subscription.new
    @plans = Stripe::Plan.all
  end

  def create
    @subscription = @user.subscription.new(subscription_params)

    if @subscription.save
      redirect_to @subscription,
                  notice: "Subscription was successfully created."
    else
      render :new
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id)
  end
end
