json.array!(@participants) do |participant|
  json.extract! participant, :id, :name, :bib_number, :wave_number
  json.url participant_url(participant, format: :json)
end
