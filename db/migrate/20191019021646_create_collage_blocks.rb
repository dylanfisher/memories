class CreateCollageBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :collage_blocks do |t|
      t.decimal :collage_height_ratio
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('CollageBlock')
          BlockKind.create name: 'CollageBlock',
                           record_type: 'default',
                           category: 'default',
                           description: ''
        end
      end

      change.down do
        BlockKind.where(name: 'CollageBlock').destroy_all
      end
    end
  end
end
