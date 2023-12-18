Trestle.resource(:orders) do
  menu do
    item :orders, :icon => "fa fa-truck",
                  :label => "Pedidos"
  end

  table do
    column :id
    column :user
    column :payment_method
    column :status
    column :total_price
    column :created_at
    actions
  end
end
