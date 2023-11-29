Trestle.resource(:product_painels) do
  menu do
    item :product_painels, icon: "fa fa-barcode",
                           :label => "Painel de Produtos",
                           :group => "Produtos"
  end

  table do
    column :id
    column :item
    column :valor
    column :category_id
    actions
  end

  form dialog: true do |product_painel|
    row do
      col (6) { text_field :item }
      col (6) { text_field :valor }
      col (6) { select :category_id, Category.all, { label: "Categoria" } }
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
  #   params.require(:product_painel).permit(:name, ...)
  # end
end
