require "image_processing/mini_magick"
 
class ImageUploader < Shrine

    plugin :cached_attachment_data
    plugin :determine_mime_type
    # plugin :remove_attachment
    plugin :validation
    plugin :validation_helpers
    # plugin :derivatives

    Attacher.validate do
        validate_max_size 100.megabytes, message: 'Attachment is too large'
        validate_mime_type_inclusion [ 'image/jpg', 'image/jpeg', 'image/png', 'image/gif' ]
    end

    # Attacher.derivatives_processor do |original|
    #     magick = ImageProcessing::MiniMagick.source(original)

    #     {
    #         large:  magick.resize_to_limit!(800, 800),
    #         medium: magick.resize_to_limit!(500, 500),
    #         small:  magick.resize_to_limit!(300, 300),
    #     }
    # end

end
