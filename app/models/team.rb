class Team < ActiveRecord::Base
    has_many :participants

    validates :category, :identifier, :presence => true
    validates :category, :uniqueness => { scope: [:identifier] }

    # Gets the total time from all participants in the team
    def sum_of_participant_timings
      timing = 0
      self.participants.each do |participant|
          timing += participant.get_timing || Float::INFINITY # if anyone null - count their timing as inf
      end
      return timing
    end
end
