class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: false
      t.references :cart, type: :uuid, foreign_key: true, null: false
      t.string :status

      t.timestamps
    end
  end
end
