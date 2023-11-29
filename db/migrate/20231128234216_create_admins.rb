class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :phone_number, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end
    add_index :admins, :email, unique: true
  end
end
