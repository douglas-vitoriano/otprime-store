class SettingsController < ApplicationController
  before_action :authenticate_user!
  helper ApplicationHelper

  def index
    @user = current_user
  end

  def update_user
    if current_user.update(user_params)
      flash[:success] = "Dados atualizados com sucesso"
      redirect_to settings_path
    else
      flash[:alert] = "Erro ao atualizar dados"
      render :index
    end
  end

  def update_password
    if !current_password_params[:current_password].blank? && current_user.valid_password?(current_password_params[:current_password])
      if current_user.update(password_params)
        bypass_sign_in(current_user)
        redirect_to settings_path, flash[:success] = "Senha atualizada com sucesso"
      else
        render :password
      end
    else
      flash[:alert] = "Digite sua senha atual"
      redirect_to password_settings_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :avatar)
  end

  def current_password_params
    params.require(:user).permit(:current_password)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
