class CreateDiscs < ActiveRecord::Migration[5.1]
  def change
    create_table :discs do |t|
      t.integer :item_id
      t.string :disc_name

      t.timestamps
    end
  end
end
