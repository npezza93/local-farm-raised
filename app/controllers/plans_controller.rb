# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :set_plan, only: [:destroy]

  def index
    @plans = Stripe::Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.valid?
      @plan.save_plan
      redirect_to plans_url, notice: "Plan was successfully created."
    else
      render :new
    end
  end

  def destroy
    @plan.delete

    redirect_to plans_url, notice: "Plan was successfully destroyed."
  end

  private

  def set_plan
    @plan = Stripe::Plan.retrieve(params[:id])
  end

  def plan_params
    params.require(:plan).permit(
      :amount, :interval, :interval_count, :name, :currency, :id
    )
  end
end
