# frozen_string_literal: true

class AddressesController < ApplicationController
  include CurrentCart
  before_action :set_cart

  before_action :set_address, only: %i(edit update destroy)

  def index
    @addresses = @user.addresses.where(archived: false)
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = @user.addresses.new(address_params)

    if @address.save
      redirect_to user_addresses_path(@user),
                  notice: "Address was successfully created."
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to user_addresses_path(@user),
                  notice: "Address was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @address.archive

    redirect_to user_addresses_url(@user),
                notice: "Address was successfully destroyed."
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(
      :first_name, :last_name, :street_address1, :street_address2, :city,
      :state, :zipcode, :phone_number, :user_id
    )
  end
end
