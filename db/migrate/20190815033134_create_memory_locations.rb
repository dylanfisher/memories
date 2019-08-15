class CreateMemoryLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :memory_locations do |t|
      t.references :location, null: false, foreign_key: true
      t.references :memory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
