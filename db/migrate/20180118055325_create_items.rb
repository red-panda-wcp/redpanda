class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :artist_name, index: true
      t.string :item_name, index: true
      t.text :image_id
      t.integer :price
      t.string :label_name, index: true
      t.integer :stock
      t.integer :category_id
      t.date :release_date

      t.timestamps
    end
  end
end
