class ApplicationController < ActionController::Base
  # include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :initialize_cart
  # before_action :redirect_based_on_role
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart = Cart.find_or_create_by(user: current_user)
    if @cart.nil?
      @cart = Cart.create(user: current_user)
      session[:cart_id] = @cart.id
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :phone)
    end
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  # private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer || admin_root_path)
  # end
end
