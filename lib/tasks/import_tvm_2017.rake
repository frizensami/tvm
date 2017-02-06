require 'csv'

namespace :tvm do

  desc 'Importing participants csv'
  task :import_participants_tsv => :environment do
    csv_file_path = 'master.tsv'

    ## We are importing a TSV file with the first row as headers
    CSV.foreach(csv_file_path, { :col_sep => "\t", :headers => true }) do |row|
      participant_name = row[5]
      participant_bib = row[2]

      puts "Trying to add #{participant_name} with bib number #{participant_bib}."
      Participant.create!({
        :name => participant_name,
        :bib_number => participant_bib,
        :wave_number => nil,
      })
      puts "#{participant_name} with bib number #{participant_bib} added!"
    end
  end
end
