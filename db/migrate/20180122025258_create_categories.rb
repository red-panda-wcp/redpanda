 class CreateCategories < ActiveRecord::Migration[5.1]
     def change
       create_table :categories do |t|
        t.string :category_name

        t.timestamps
      end
    end
end