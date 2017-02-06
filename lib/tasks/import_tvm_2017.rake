require 'csv'

namespace :tvm do

  desc 'Importing participants csv'
  task :import_participants_tsv => :environment do

    # Constants
    csv_file_path = 'master.tsv'
    non_team_bib_letters = ['M', 'F', 'W']

    ## We are importing a TSV file with the first row as headers
    CSV.foreach(csv_file_path, { :col_sep => "\t", :headers => true }) do |row|
      participant_name = row[5]
      participant_bib = row[2]

      puts "Trying to add #{participant_name} with bib number #{participant_bib}."
      participant = Participant.create!({
        :name => participant_name,
        :bib_number => participant_bib,
        :wave_number => nil,
      })
      puts "#{participant_name} with bib number #{participant_bib} added!"

      # Create a team for this participant. Participant validation includes
      # bib validation so we don't need to worry here that it's badly formatted

      # first two characters = category
      category = participant_bib[0..1]
      identifier = nil

      # If this an "individual" - just create the team
      if non_team_bib_letters.include? participant_bib.first
        # the rest
        identifier = participant_bib[2..-1]
        # we need to create the required team
        team = Team.create!({ category: category, identifier: identifier })
        puts "Individual team created, category: #{category}, identifier: #{identifier}"
      else
        # This is a team with more than 1 member - TVM couple / team.
        # the identifier is a bit harder to calculate.
        # For couples - this is the sequence: 101 & 102, then 111 & 112, ...
        # For teams - this is the sequence: 101 - 105, then 111 - 115, ...
        # We take the first person of the sequence as the team identifier (logical captain)
        # Then we can derive the team identifier as the bib digits with the last
        # digit as 1. This means that 101 -> 101, 102 -> 101, etc.

        # just two numbers from the bib with a 1 appended
        # This method assumes that the bib numbers are correct
        identifier = (participant_bib[2..-2] + "1")

        matching_team = Team.where(category: category, identifier: identifier).first
        if matching_team.present?
          # the team is already created - add the current participant to the team
          participant.team = matching_team
          puts "Matching team present, assigning participant to team - category: #{category}, identifier: #{identifier}"
        else
          # we need to create the required team
          team = Team.create!({ category: category, identifier: identifier })
          participant.team = team
          puts "Real team created, category: #{category}, identifier: #{identifier}"
        end
      end
    end
  end
end
