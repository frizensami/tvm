class AddDeletedAtToWaves < ActiveRecord::Migration
  def change
    add_column :waves, :deleted_at, :datetime
    add_index :waves, :deleted_at
  end
end
