class RemoveFistNameFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :fist_name, :name
  end
end
