class CreateLayers < ActiveRecord::Migration[6.1]
  def change
    create_table :layers do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
