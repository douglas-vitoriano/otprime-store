class RemoveForeignKeyFromRequests < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :requests, :user_lists
  end
end
