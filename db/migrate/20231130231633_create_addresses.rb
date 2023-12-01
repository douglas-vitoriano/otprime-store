class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :name, null: false
      t.string :street, null: false
      t.string :neighborhood, null: false
      t.string :number, null: false
      t.string :zipcode, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.boolean :main, null: false, default: false
      t.numeric :user_id, null: false

      t.timestamps

      t.index :user_id, name: "addresses_user"
      t.index :id, unique: true
    end
  end
end
