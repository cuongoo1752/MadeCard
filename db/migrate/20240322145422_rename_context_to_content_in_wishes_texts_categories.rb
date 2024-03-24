class RenameContextToContentInWishesTextsCategories < ActiveRecord::Migration[6.1]
  def change
    rename_column :wishes, :context, :content
    rename_column :texts, :context, :content
    rename_column :categories, :context, :content
  end
end
