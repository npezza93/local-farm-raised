class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :set_user
  before_filter :auth_address_book

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = @user.addresses
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = @user.addresses.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to user_addresses_path(@user), notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to user_addresses_path(@user), notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to user_addresses_url(@user), notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def auth_address_book
      unless @user = current_user
        redirect_to store_url
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:first_name, :last_name, :street_address1, :street_address2, :city, :state, :zipcode, :phone_number, :user_id)
    end
end
