class CreateFixPictures < ActiveRecord::Migration[6.1]
  def change
    create_table :fix_pictures do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
