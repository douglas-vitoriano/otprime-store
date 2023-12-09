class AddColumnsToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :address_detail, :string
  end
end
