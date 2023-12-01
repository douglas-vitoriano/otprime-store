Trestle.resource(:products) do
  menu do
    item :product_painels, icon: "fa fa-barcode",
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

  # controller do
  #   before_action :set_product, only: [:show, :update, :destroy]

  #   def show
  #   end

  #   def create
  #     @product = Product.new(product_params)

  #     respond_to do |format|
  #       if @product.save
  #         format.html { redirect_to products_admin_path(@product), notice: "Produto criado com sucesso." }
  #         format.json { render :show, status: :created, location: @product }
  #       else
  #         format.html { render :new, status: :unprocessable_entity }
  #         format.json { render json: @product.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end

  #   def update
  #     respond_to do |format|
  #       if @product.update(product_params)
  #         format.html { redirect_to products_admin_path(@product), notice: "Produto atualizado com sucesso." }
  #         format.json { render :show, status: :ok, location: @product }
  #       else
  #         format.html { render :edit, status: :unprocessable_entity }
  #         format.json { render json: @product.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end

  #   private

  #   def set_product
  #     @product = Product.find(params[:id])

  #     unless @product
  #       respond_to do |format|
  #         format.html { redirect_to products_admin_path, alert: "Produto não encontrado." }
  #         format.json { head :not_found }
  #       end
  #     end
  #   end

  #   def product_params
  #     params.require(:product).permit(:name, :description, :publish, :price, :category_id)
  #   end
  # end

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
