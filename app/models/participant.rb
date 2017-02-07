class Participant < ActiveRecord::Base
  # Always belong to a team
  belongs_to :team

  validates :name, :bib_number, :presence => true

  validates :bib_number, :uniqueness => true

  # MTCFW - Male/Team/Couple/Female/Women, ON - Open/NUS, then 3 digits
  validates :bib_number, :format => { with: /[MTCFW][ON]\d{3}/, message: "must match regex [MTCFW][ON]\\d{3}" }

  #cannot input a wave that has already started
  validate :wave_cannot_have_started
  validate :limit_number_of_participants_in_wave

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid

  def wave_cannot_have_started
    if Wave.exists?(wave_number: wave_number)
      errors.add(:wave_number, "is not allowed. Wave has already started.")
    end
  end

  def limit_number_of_participants_in_wave
    if self.wave_number.present? && Participant.where(wave_number: self.wave_number).count >= Wave::MAX_PARTICIPANTS_IN_WAVE
      errors.add(:wave_number, "is incorrect, only #{Wave::MAX_PARTICIPANTS_IN_WAVE} people can be in one wave. Please allocate participant to the next wave.")
    end
  end

  # Gets this participant's total elapsed time to complete the race
  def get_timing
    participant = self
    rank_participant = RankParticipant.find_by(bib_number: participant.bib_number)

    rank = nil
    wave_number = nil
    end_time = nil
    start_time = nil
    time_delta = nil

    #get a wave object to check for a start time
    wave_number = participant.wave_number

    unless wave_number.blank? || !Wave.exists?(wave_number: participant.wave_number)
      start_time = Wave.find_by(wave_number: participant.wave_number).start_time

      unless rank_participant.nil?
        #if we have a participant with a rank, get the timing object to check end time
        rank = rank_participant.rank
        timing_object = Rank.find_by(rank: rank)

        unless timing_object.nil?
          #if we do have a timing object, get the end time
          end_time = timing_object.end_time
          time_delta_float_seconds = end_time - start_time
        end

      end
    end

    return time_delta_float_seconds
  end

  end
