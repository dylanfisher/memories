class AddExifDataToMediaItems < ActiveRecord::Migration[6.0]
  def change
    add_column :media_items, :exif_data, :jsonb, default: {}
  end
end
