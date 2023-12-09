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

  private

  def user_params
    params.require(:user).permit(:name, :phone, :avatar)
  end
end
