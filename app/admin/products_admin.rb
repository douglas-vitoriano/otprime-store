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
    column :image do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_limit: [100, 100]).processed.url
      else
        "Sem imagem"
      end
    end
    actions
  end

  form dialog: true do |product|
    row do
      col(6) { text_field :name, { label: "Nome" } }
      col(6) { text_field :price, { label: "Preço" } }
    end
    row do
      col(6) { select :category_id, Category.all, { label: "Categoria" } }
      col(6) { file_field :image, { label: "Imagem" } }
    end
    row do
      col { text_area :description, { label: "Descruição" } }
    end
    row do
      col(6) { check_box :publish, { label: "Publico?" } }
      col(6) { check_box :promo, { label: "Promoção?" } }
    end
    row do
      col { text_field :promo_price, { label: "Preço da Promoção" } }
    end
  end

  controller do
    include Pundit::Authorization
    before_action :authenticate_user!
    before_action do
      ActiveStorage::Current.url_options = Rails.application.config.action_mailer.default_url_options
    end

    def index
      @products = Product.published
    end

    def show
      @products = Product.where(publish: true)

      begin
        @product = Product.find(params[:id])
        # authorize @product
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Produto não encontrado."
      end
    end

    def create
      @product = Product.new(product_params)

      @product.image.attach(params[:product][:image])

      if @product.save
        redirect_to products_admin_url(@product), notice: "Produto criado com sucesso."
      else
        render :new
      end
    end

    # def url_for(options = nil)
    #   if options.is_a?(Hash) && options.key?(:_path_segments)
    #     main_app.url_for(options)
    #   else
    #     super
    #   end
    # end

    # def new
    #   @product = authorize Product.new
    # rescue Pundit::NotAuthorizedError
    #   flash[:error] = "Você não tem permissão para criar um novo produto sem uma categoria"
    #   redirect_to new_categories_admin_path
    # end
    def destroy
      @product = Product.find(params[:id])
      # authorize @product
      if @product.image.attached?
        @product.image.purge
      end
      @product.destroy
      flash[:message] = "Produto excluído com sucesso."
      render :new
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :publish, :image, :category_id, :promo, :promo_price)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end

  routes do
    resources :products_admin, only: [:index, :show, :new, :create, :destroy]
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
