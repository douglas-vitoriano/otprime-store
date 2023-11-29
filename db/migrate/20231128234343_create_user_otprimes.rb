class CreateUserOtprimes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_otprimes do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.string :phone_number

      t.timestamps
    end
    add_index :user_otprimes, :email, unique: true
  end
end
