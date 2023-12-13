class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :role_user, ["user", "admin"]

    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :encrypted_password
      t.string :reset_password_token
      t.string :reset_password_sent_at
      t.datetime :remember_created_at
      t.column :role, :role_user, default: "user", null: false

      t.timestamps

      t.index [:id, :email], unique: true
      t.index [:reset_password_token], unique: true
    end
  end
end
