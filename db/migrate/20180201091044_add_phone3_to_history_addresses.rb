class AddPhone3ToHistoryAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :history_addresses, :phone3, :string
  end
end
