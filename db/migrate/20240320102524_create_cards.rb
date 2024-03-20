class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.boolean :is_public
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
