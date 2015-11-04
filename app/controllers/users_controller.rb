class UsersController < ApplicationController
  before_filter :auth_user, except: [:settings]
  before_action :set_user, only: [:admin]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.where.not(id: current_user.id).paginate(:page => params[:page], per_page: 30)
  end

  def settings
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def admin
    respond_to do |format|
      if @user.update({admin: !@user.admin})
        notice = @user.admin? ? @user.email + " is now an admin" : @user.email + " is no longer an admin"
        format.html { redirect_to users_url, notice: notice }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :index }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def add_addresses
      redirect_to settings_path
    end
end
