class Participant < ActiveRecord::Base
	validates :name, :bib_number, :wave_number, :presence => true
	
	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid
end
