class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :phone_number, :password, :password_confirmation)
    end
  end
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_my_accounts_path
    else
      root_path
    end
  end
end
