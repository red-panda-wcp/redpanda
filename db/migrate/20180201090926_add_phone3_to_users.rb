class AddPhone3ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone3, :string
  end
end
