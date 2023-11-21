class SessionsController < Devise::SessionsController
  protected

  def after_sign_out_path_for(resource_or_scope)
    redirect_to = params[:redirect_to]
    redirect_to.presence || root_path
  end
end
