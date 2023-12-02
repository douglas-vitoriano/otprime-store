class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      redirect_to admin_root_path
    else
      redirect_to root_path
    end
  end
end
