class Rank < ActiveRecord::Base
	validates :rank, :end_time, :presence => true
end
