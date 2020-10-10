class IndexMemoriesOnDate < ActiveRecord::Migration[6.0]
  def change
    add_index :memories, :date
  end
end
