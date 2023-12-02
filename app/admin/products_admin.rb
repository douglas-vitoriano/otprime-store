Trestle.resource(:products) do
  menu do
    item :products, icon: "fa fa-barcode",
                    :label => "Painel de Produtos",
                    :group => "Produtos"
  end

  table do
    column :name
    column :price
    column :publish, ->(product) { product.publish ? "Sim" : "Não" }
    column :category_name, ->(product) { product.category.name }
    actions
  end

  form dialog: true do |product|
    row do
      col(6) { text_field :name, { label: "Nome" } }
      col(6) { text_field :price, { label: "Preço" } }
    end
    row do
      col(6) { select :category_id, Category.all, { label: "Categoria" } }
    end
    row do
      col { text_area :description, { label: "Descruição" } }
    end
    row do
      col { check_box :publish, { label: "Publico?" } }
    end
  end

  controller do
    include Pundit

    def new
      @product = authorize Product.new
    rescue Pundit::NotAuthorizedError
      flash[:error] = "Você não tem permissão para criar um novo produto sem uma categoria"
      redirect_to new_categories_admin_path
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
