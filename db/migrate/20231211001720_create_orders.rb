class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string "status"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "payment_method", default: 0
      t.integer "quantity", default: 1

      t.references :cart, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: true
    end
  end
end
