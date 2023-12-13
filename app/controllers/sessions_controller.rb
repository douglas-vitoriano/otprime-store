class SessionsController < Devise::SessionsController
  def create
    super do |user|
      Cart.create(user: user) if user.sign_in_count == 1
    end
  end

  protected

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_root_path : root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
