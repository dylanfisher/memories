class RemoveNotNullViolationFromCollageBlockItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :collage_block_items, :media_item_id, true
    change_column_null :collage_block_items, :collage_block_id, true
  end
end
