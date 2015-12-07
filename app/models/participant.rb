class Participant < ActiveRecord::Base
	validates :name, :bib_number, :wave_number, :presence => true
end
