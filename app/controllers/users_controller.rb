# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :auth_admin
  before_action :set_user, only: :update

  def index
    @users =
      User.where.not(id: current_user.id).page(params[:page]).per(30).order(:id)
  end

  def update
    @user.update(admin: !@user.admin)

    notice = @user.email
    notice += @user.admin? ? " is now an admin" : " is no longer an admin"

    redirect_to users_path(page: params[:page], anchor: @user.id),
                notice: notice
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
