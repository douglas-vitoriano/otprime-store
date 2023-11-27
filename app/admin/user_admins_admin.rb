Trestle.resource(:user_admins) do
  menu do
    item :user_admins, icon: "fa fa-lock"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :email
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |user_admin|
    text_field :name
    text_field :email
    password_field :password
    password_field :password_confirmation
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user_admin).permit(:name, ...)
  # end
end
