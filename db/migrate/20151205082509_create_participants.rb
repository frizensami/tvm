class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :bib_number
      t.integer :wave_number

      t.timestamps null: false
    end
  end
end
