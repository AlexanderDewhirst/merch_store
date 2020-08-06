namespace :shrine do
    task :populate_derivatives => :environment do
        Photo.find_each do |photo|
            attacher = photo.image_attacher
            
            next unless attacher.stored?
            
            attacher.create_derivatives
            
            begin
                attacher.atomic_persist
            rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
                attacher.delete_derivatives
            end
        end
    end
end