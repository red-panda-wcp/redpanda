class AddPhone2ToHistoryAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :history_addresses, :phone2, :string
  end
end
