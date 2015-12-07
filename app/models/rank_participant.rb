class RankParticipant < ActiveRecord::Base
	validates :rank, :name, :bib_number, :presence => true
end
