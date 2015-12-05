class CreateWaves < ActiveRecord::Migration
  def change
    create_table :waves do |t|
      t.integer :wave_number
      t.datetime :start_time

      t.timestamps null: false
    end
  end
end
