class CreateRankParticipants < ActiveRecord::Migration
  def change
    create_table :rank_participants do |t|
      t.integer :rank
      t.string :name
      t.string :bib_number

      t.timestamps null: false
    end
  end
end
