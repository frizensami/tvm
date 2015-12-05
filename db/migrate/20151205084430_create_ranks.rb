class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :rank
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
