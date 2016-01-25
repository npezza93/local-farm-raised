class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]
  before_action :set_user

  # GET /subscriptions
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @plans = Stripe::Plan.all
  end

  # POST /subscriptions
  def create
    @subscription = @user.subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:plan_id)
    end
end
