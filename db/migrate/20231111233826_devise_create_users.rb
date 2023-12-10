class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.numeric :id, primary_key: true, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.integer :role, null: false
      t.string :phone, null: false
      t.string :encrypted_password, null: false
      t.string :reset_password_token, null: false
      t.string :reset_password_sent_at, null: false
      t.datetime :remember_created_at, null: false
      t.timestamps null: false

      t.index [:id, :email], unique: true
    end
  end
end
