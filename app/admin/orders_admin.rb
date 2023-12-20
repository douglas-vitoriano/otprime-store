Trestle.resource(:orders) do
  menu do
    item :orders, :icon => "fa fa-truck",
                  :label => "Pedidos"
  end

  table do
    column :id, link: true, header: "ID" do |order|
      order.id.to_s.first(8)
    end
    column :user
    column :product
    column :total_price
    column :created_at do |order|
      order.created_at.strftime("%d/%m/%Y %H:%M:%S")
    end
  end

  controller do
    def new
      flash[:error] = "A criação de novos pedidos não é permitida."
      redirect_to admin.path(:index)
    end

    def show
      flash[:error] = "A visualização detalhada de pedidos não é permitida."
      redirect_to admin.path(:index)
    end

    def destroy
      order = Order.find(params[:id])

      if SecondModal.where(order_id: order.id).any?
        flash[:error] = "O registro não pode ser excluído, pois ainda é referenciado em outras tabelas."
      else
        order.destroy
        flash[:success] = "Registro excluído com sucesso."
      end

      redirect_to admin.path(:index)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Registro não encontrado."
      redirect_to admin.path(:index)
    end
  end
end
