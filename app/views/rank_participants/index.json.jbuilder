json.array!(@rank_participants) do |rank_participant|
  json.extract! rank_participant, :id, :rank, :name, :bib_number
  json.url rank_participant_url(rank_participant, format: :json)
end
