class AddDeletedAtToRankParticipants < ActiveRecord::Migration
  def change
    add_column :rank_participants, :deleted_at, :datetime
    add_index :rank_participants, :deleted_at
  end
end
