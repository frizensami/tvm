class Wave < ActiveRecord::Base
	validates :wave_number, :start_time, :presence => true

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid
end
