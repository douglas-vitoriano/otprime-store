class AddStatusAndPaymentMethodReferencesToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference(:orders, :status, foreign_key: true, type: :uuid, default: 1)
    add_reference(:orders, :payment_method, foreign_key: true, type: :uuid, default: 1)
  end
end
