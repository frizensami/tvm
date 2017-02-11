class Wave < ActiveRecord::Base
	validates :wave_number, :start_time, :presence => true

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid

    MAX_PARTICIPANTS_IN_WAVE = 5


end
