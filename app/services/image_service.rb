class ImageService
  def self.save(instance, folder, name, record_type, record_id)
    if instance.attached?
      begin
        final_filename = instance.blob.filename.to_s.downcase
        final_filename = final_filename.gsub("#{folder}-", "").gsub(" ", "-")
        final_filename = "#{folder}/#{final_filename}"
        blob = ActiveStorage::Blob.find_by(key: final_filename)

        unless blob.nil?
          instance.purge
          attach = ActiveStorage::Attachment.find_or_create_by!(name: name, record_type: record_type, blob_id: blob.id, record_id: record_id)
        else
          instance.filename = final_filename
          instance.blob.update(key: final_filename)
        end
      rescue Exception => e
        Rails.logger.error("#{e.message}")
      end
    end
  end
end
