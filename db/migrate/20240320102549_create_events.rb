class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :content
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
