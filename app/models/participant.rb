class Participant < ActiveRecord::Base
  # Always belong to a team
  belongs_to :team

	validates :name, :bib_number, :presence => true

  validates :bib_number, :uniqueness => true

  # MTCFW - Male/Team/Couple/Female/Women, ON - Open/NUS, then 3 digits
  validates :bib_number, :format => { with: /[MTCFW][ON]\d{3}/, message: "must match regex [MTCFW][ON]\\d{3}" }

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
