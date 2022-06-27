class RemoveIsActiceFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :is_actice, :boolean
  end
end
