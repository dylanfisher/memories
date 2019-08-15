class CreateImageBlockItems < ActiveRecord::Migration[6.0]
  def change
    create_table :image_block_items do |t|
      t.references :image_block, null: false, foreign_key: true
      t.references :media_item, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
