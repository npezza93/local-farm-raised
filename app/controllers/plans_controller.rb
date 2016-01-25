class PlansController < ApplicationController
  before_action :set_plan, only: [:destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Stripe::Plan.all
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    respond_to do |format|
      if @plan.valid?
        @plan.save_plan
        format.html { redirect_to plans_url, notice: 'Plan was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.delete
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Stripe::Plan.retrieve(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:amount, :interval, :interval_count, :name, :currency, :id)
    end
end
