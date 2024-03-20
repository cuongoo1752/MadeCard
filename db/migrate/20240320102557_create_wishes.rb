class CreateWishes < ActiveRecord::Migration[6.1]
  def change
    create_table :wishes do |t|
      t.references :category, null: false, foreign_key: true
      t.text :context
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
