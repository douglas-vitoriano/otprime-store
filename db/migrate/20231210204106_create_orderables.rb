class CreateOrderables < ActiveRecord::Migration[7.0]
  def change
    create_table :orderables, id: :uuid do |t|
      t.uuid :product_id
      t.belongs_to :cart, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end
