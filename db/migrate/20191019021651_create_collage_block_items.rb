class CreateCollageBlockItems < ActiveRecord::Migration[6.0]
  def change
    create_table :collage_block_items do |t|
      t.references :media_item, null: false, foreign_key: true
      t.references :collage_block, null: false, foreign_key: true
      t.decimal :collage_position_left
      t.decimal :collage_position_top
      t.decimal :collage_item_width
      t.decimal :collage_item_height
      t.integer :collage_z_index

      t.timestamps
    end
  end
end
