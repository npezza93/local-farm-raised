# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :auth_admin
  before_action :set_plan, only: :destroy

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to plans_path, notice: "Plan was successfully created."
    else
      render :new
    end
  end

  def destroy
    @plan.destroy

    redirect_to plans_url, notice: "Plan was successfully destroyed."
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:amount, :name, :id)
  end
end
