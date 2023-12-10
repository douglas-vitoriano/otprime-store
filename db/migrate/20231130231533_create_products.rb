class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ""
      t.decimal :price, precision: 8, scale: 2, null: false
      t.references :category, null: false, type: :uuid, foreign_key: true
      t.boolean :publish, null: false, default: false
      t.boolean :promo, default: false
      t.decimal :promo_price, precision: 8, scale: 2, default: "0.0"

      t.timestamps

      t.index :id, unique: true
    end
  end
end
