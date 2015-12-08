class Rank < ActiveRecord::Base
	validates :rank, :end_time, :presence => true

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid
end
