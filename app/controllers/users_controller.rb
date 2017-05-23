# frozen_string_literal: true

class UsersController < ApplicationController
  include CurrentCart
  before_action :set_cart

  before_action :auth_user, except: [:settings]
  before_action :set_user, only: [:admin]

  def index
    @users = User.where.not(
      id: current_user.id
    ).page(params[:page]).per_page(30)
  end

  def settings
  end

  def admin
    if @user.update({admin: !@user.admin})
      notice = @user.email
      notice += @user.admin? ? " is now an admin" : " is no longer an admin"
      redirect_to users_url, notice: notice
    else
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def add_addresses
    redirect_to settings_path
  end
end
