class CreateImageBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :image_blocks do |t|
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('ImageBlock')
          BlockKind.create name: 'ImageBlock',
                           record_type: 'default',
                           category: 'default',
                           description: ''
        end
      end

      change.down do
        BlockKind.where(name: 'ImageBlock').destroy_all
      end
    end
  end
end
