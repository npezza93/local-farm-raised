# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_addresses
  before_action :set_address, only: %i(edit update destroy)

  def index
  end

  def new
    @address = @addresses.new
  end

  def edit
  end

  def create
    @address = @addresses.new(address_params)

    if @address.save
      redirect_to post_create_redirect_path,
                  notice: "Successfully added to address book"
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: "Address was updated"
    else
      render :edit
    end
  end

  def destroy
    @address.archive

    redirect_to addresses_url, notice: "Address removed"
  end

  private

  def set_addresses
    @addresses = current_user.addresses
  end

  def set_address
    @address = @addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(
      :first_name, :last_name, :street_address1, :street_address2, :city,
      :state, :zipcode, :phone_number
    )
  end

  def post_create_redirect_path
    return addresses_path unless params[:referrer] == new_order_url

    new_order_path
  end
end
