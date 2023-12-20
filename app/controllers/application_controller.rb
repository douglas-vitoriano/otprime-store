class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_render_cart
  before_action :initialize_cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    return unless user_signed_in?

    @cart = current_user.cart || current_user.create_cart

    if @cart.persisted?
      flash[:success] = "Carrinho criado com sucesso!"
    else
      flash[:error] = "Erro ao criar o carrinho."

      redirect_to root_path and return
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :phone)
    end
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_path : root_path
  end
end
