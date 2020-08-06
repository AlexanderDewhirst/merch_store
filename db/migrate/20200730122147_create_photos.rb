class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|

      t.string :filename
      t.string :content_type
      t.jsonb :image_data, default: '{}'
      t.integer :product_id

      t.timestamps
    end
  end
end
