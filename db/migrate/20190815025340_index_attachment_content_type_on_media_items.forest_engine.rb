# This migration comes from forest_engine (originally 20170910204934)
class IndexAttachmentContentTypeOnMediaItems < ActiveRecord::Migration[5.1]
  def change
    add_index :media_items, :attachment_content_type
  end
end
