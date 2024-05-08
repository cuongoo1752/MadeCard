class AddDimensionsToImage < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :width, :integer
    add_column :images, :height, :integer
    add_column :images, :top, :integer
    add_column :images, :left, :integer
  end
end
