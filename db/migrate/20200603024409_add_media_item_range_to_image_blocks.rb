class AddMediaItemRangeToImageBlocks < ActiveRecord::Migration[6.0]
  def change
    add_column :image_blocks, :media_item_range, :string
    add_column :image_blocks, :media_item_skip_range, :string
  end
end
