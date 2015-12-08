class RankParticipant < ActiveRecord::Base
	validates :rank, :name, :bib_number, :presence => true

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid
end
