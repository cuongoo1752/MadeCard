class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :role
      t.integer :status
      t.string :order
      t.string :integer

      t.timestamps
    end
  end
end
