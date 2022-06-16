class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.integer :item_image
      t.text :introduction
      t.integer :price
      t.boolean :is_actice

      t.timestamps
    end
  end
end
