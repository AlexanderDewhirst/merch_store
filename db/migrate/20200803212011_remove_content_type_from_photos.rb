class RemoveContentTypeFromPhotos < ActiveRecord::Migration[6.0]
  def change
    remove_column :photos, :content_type
  end
end
