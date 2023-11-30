class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.numeric :category_id, null: false
      t.boolean :publish, null: false, default: false
      t.timestamps null: false

      t.index :category_id, name: "products_category"
      t.index :id, unique: true
    end
  end
end
