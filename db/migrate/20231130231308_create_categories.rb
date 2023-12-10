class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 0

      t.timestamps

      t.index :name, name: "categories_name"
      t.index :id, unique: true
    end
  end
end
