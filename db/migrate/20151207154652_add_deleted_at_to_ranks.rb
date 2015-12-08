class AddDeletedAtToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :deleted_at, :datetime
    add_index :ranks, :deleted_at
  end
end
