class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.references :event, null: false, foreign_key: true
      t.string :context
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
