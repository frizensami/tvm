require 'csv'

namespace :tvm do

  desc 'Importing participants csv'
  task :import_participants_tsv => :environment do
    csv_file_path = 'master.tsv'

    ## We are importing a TSV file with the first row as headers
    CSV.foreach(csv_file_path, { :col_sep => "\t", :headers => true }) do |row|
      puts "Trying to add #{row[5]} with bib number #{row[2]}."
      Participant.create!({
        :name => row[5],
        :bib_number => row[2],
        :wave_number => nil,
      })
      puts "#{row[5]} with bib number #{row[2]} added!"
    end
  end
end
