class AddFixPictureIdToCard < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :fix_picture_id, :integer
  end
end
