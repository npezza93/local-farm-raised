class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def current_cart
    @current_cart ||= Cart.find_or_create_by_session(session)
    session[:cart_id] ||= @current_cart.id

    @current_cart
  end
  helper_method :current_cart

  private
    def auth_user
      if !current_user.try(:admin?)
        redirect_to store_url, notice: "You are not authorized to view this page"
      end
    end

end
