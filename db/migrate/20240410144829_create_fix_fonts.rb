class CreateFixFonts < ActiveRecord::Migration[6.1]
  def change
    create_table :fix_fonts do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.string :font
      t.integer :status

      t.timestamps
    end
  end
end
