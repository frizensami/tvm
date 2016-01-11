require 'csv'

namespace :csv do

  desc 'Importing participants csv'
  task :import_participants => :environment do
    csv_file_path = 'participants.csv'

    CSV.foreach(csv_file_path) do |row|
      Participant.create!({
        :name => row[1],
        :bib_number => row[3],
        :wave_number => nil,
      })
      puts "#{row[1]} added!"
    end
  end
end
