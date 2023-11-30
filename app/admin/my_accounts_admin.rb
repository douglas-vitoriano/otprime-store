Trestle.resource(:my_accounts) do
  menu do
    item :my_accounts, icon: "fa fa-lock",
                       label: "Minha Conta",
                       group: "Configurações"
  end
  remove_action :new
  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :email
    column :phone
    column :password do |my_account|
      content_tag(:div, class: "static-password-field", data: { mask: "*********" }) do
        "*********"
      end
    end
  end

  form do |my_account|
    row do
      col { text_field :name }
    end
    row do
      col { text_field :phone }
      col { email_field :email }
    end
    row do
      col { password_field :password }
      col { password_field :password_confirmation }
    end
  end

  # Customize the form fields shown on the new/edit views.

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:my_account).permit(:name, ...)
  # end
end
