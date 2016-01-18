module RankParticipantsHelper
  def missing_numbers
    if Rank.count > 0
      return (Rank.minimum(:rank)...Rank.maximum(:rank)).to_a - Rank.pluck(:rank)
    end
  end
end
