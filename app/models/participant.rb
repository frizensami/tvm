class Participant < ActiveRecord::Base
	validates :name, :bib_number, :presence => true

  #cannot input a wave that has already started
  validate :wave_cannot_have_started

	#PARANOID MODE: Nothing really gets deleted
	acts_as_paranoid

  def wave_cannot_have_started
    if Wave.exists?(wave_number: wave_number)
      errors.add(:wave_number, "is not allowed. Wave has already started.")
    end
  end

end
