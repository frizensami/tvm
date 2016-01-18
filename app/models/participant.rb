class Participant < ActiveRecord::Base
	validates :name, :bib_number, :presence => true

  #cannot input a wave that has already started
  validate :wave_cannot_have_started
  validate :only_five_in_a_wave

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid

  def wave_cannot_have_started
    if Wave.exists?(wave_number: wave_number)
      errors.add(:wave_number, "is not allowed. Wave has already started.")
    end
  end

  def only_five_in_a_wave
    if self.wave_number.present? && Participant.where(wave_number: self.wave_number).count >= 5
      errors.add(:wave_number, "is incorrect, only 5 people can be in one wave. Please allocate participant to the next wave.")
    end
  end

end
