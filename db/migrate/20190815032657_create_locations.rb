class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.string :slug

      t.timestamps
    end
    add_index :locations, :slug, unique: true
  end
end
