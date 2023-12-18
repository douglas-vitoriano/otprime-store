class AddColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :product_id, :uuid
  end
end
