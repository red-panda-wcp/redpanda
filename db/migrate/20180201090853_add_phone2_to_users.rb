class AddPhone2ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone2, :string
  end
end
