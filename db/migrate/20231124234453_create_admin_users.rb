class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.string :nome
      t.string :cpf
      t.string :password

      t.timestamps
    end
    add_index :admin_users, :cpf, unique: true
  end
end
