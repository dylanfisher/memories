require 'exifr/jpeg'

MediaItem.class_eval do
  after_post_process :parse_exif_data

  private

    def parse_exif_data
      return unless image? && (attachment_content_type == 'image/jpeg')
      tempfile = attachment.queued_for_write[:original]
      unless tempfile.nil?
        exif = EXIFR::JPEG.new(tempfile.path)
        self.exif_data = exif.to_hash
      end
    end
end
