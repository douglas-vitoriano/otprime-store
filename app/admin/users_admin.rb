Trestle.resource(:users) do
  menu do
    item :users, :icon => "fa fa-star",
                 :label => "Usuários",
                 :group => "Administrador",
                 :priority => 0
  end

  table do
    column :name
    column :email
    column :role
    actions
  end

  form dialog: true do |user|
    row do
      col(6) { text_field :name, { label: "Nome" } }
      col(6) { text_field :email, { label: "Email" } }
    end
    row do
      col(6) { text_field :phone, { label: "Telefone" } }
      col(6) { select :role, User.roles.keys, { label: "Função" } }
    end
    row do
      col(6) { password_field :password, { label: "Senha" } }
      col(6) { password_field :password_confirmation, { label: "Confirmação de Senha" } }
    end
  end

  controller do
    def toggle_admin
      @user = User.find(params[:id])
      @user.toggle!(:admin)
      redirect_to admin_users_path, notice: "Função do usuário alterada com sucesso."
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
end
