class RemoveOrderAndRenameIntegerColumnInUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :order
    rename_column :users, :integer, :order
  end
end
