class Wave < ActiveRecord::Base
	validates :wave_number, :start_time, :presence => true
end
