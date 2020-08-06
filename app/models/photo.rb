class Photo < ApplicationRecord
    include ImageUploader::Attachment(:image)
    belongs_to :product

end
