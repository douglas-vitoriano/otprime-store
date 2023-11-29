class CreateUserAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :user_admins do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
