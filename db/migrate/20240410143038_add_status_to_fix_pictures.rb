class AddStatusToFixPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :fix_pictures, :status, :integer
  end
end
