class RemoveFistNameKanaFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :fist_name_kana, :name
  end
end
