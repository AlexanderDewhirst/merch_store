class ChangePhotoImageDataToText < ActiveRecord::Migration[6.0]
  def change
    remove_column :photos, :image_data
    add_column :photos, :image_data, :text
  end
end
