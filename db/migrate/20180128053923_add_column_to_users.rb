class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address2, :string
    add_column :history_addresses, :address2, :string
  end
end
