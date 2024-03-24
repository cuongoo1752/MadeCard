class AddDimensionsToTexts < ActiveRecord::Migration[6.1]
  def change
    add_column :texts, :width, :integer
    add_column :texts, :height, :integer
    add_column :texts, :top, :integer
    add_column :texts, :left, :integer
  end
end
