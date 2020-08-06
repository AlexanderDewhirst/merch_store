class RemoveFilenameFromPhotos < ActiveRecord::Migration[6.0]
  def change
    remove_column :photos, :filename
  end
end
