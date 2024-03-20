class CreateTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :texts do |t|
      t.text :context
      t.boolean :is_long
      t.string :font
      t.string :color
      t.integer :size
      t.string :text_align
      t.string :vertical
      t.string :text_type
      t.integer :status

      t.timestamps
    end
  end
end
