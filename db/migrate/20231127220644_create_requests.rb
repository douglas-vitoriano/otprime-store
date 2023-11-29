class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :number_request
      t.date :date
      t.string :status
      t.references :user_list, foreign_key: true

      t.timestamps
    end
  end
end
