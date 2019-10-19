class CreateImageSequenceBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :image_sequence_blocks do |t|
      t.integer :duration, default: 300
      t.integer :col_size, default: 12
      t.integer :col_offset, default: 0
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('ImageSequenceBlock')
          BlockKind.create name: 'ImageSequenceBlock',
                           record_type: 'default',
                           category: 'default',
                           description: ''
        end
      end

      change.down do
        BlockKind.where(name: 'ImageSequenceBlock').destroy_all
      end
    end
  end
end
