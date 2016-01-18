module RankParticipantsHelper
  def missing_numbers
    return (Rank.minimum(:rank)...Rank.maximum(:rank)).to_a - Rank.pluck(:rank)
  end
end
