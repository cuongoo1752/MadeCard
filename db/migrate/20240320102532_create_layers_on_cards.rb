class CreateLayersOnCards < ActiveRecord::Migration[6.1]
  def change
    create_table :layers_on_cards do |t|
      t.string :name
      t.references :card, null: false, foreign_key: true
      t.integer :layer_id
      t.string :layer_type
      t.integer :status
      t.integer :order
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
