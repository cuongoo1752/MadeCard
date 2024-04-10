class CreateFakeTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :fake_texts do |t|
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
