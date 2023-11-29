Trestle.resource(:categories) do
  menu do
    item :categories, icon: "fa fa-cube",
                      label: "Categorias de Produtos",
                      group: "Produtos"
  end

  # Customize the table columns shown on the index view.
  table do
    column :id
    column :name
    column :position
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form dialog: true do |category|
    row do
      col (6) { text_field :name }
      col (6) { text_field :position }
    end
    row do
      col { date_field :created_at }
    end
  end

  controller do
    before_action :set_category, only: [:show, :update, :destroy]

    def show
    end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to categories_admin_path(@category), notice: "Categoria criada com sucesso." }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to categories_admin_path(@category), notice: "Categoria atualizada com sucesso." }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @category.destroy

      respond_to do |format|
        format.html { redirect_to categories_admin_path, notice: "Categoria excluída com sucesso." }
        format.json { head :no_content }
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :position)
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
  #   params.require(:category).permit(:name, ...)
  # end
end
