json.array!(@teams) do |team|
  json.extract! team, :id, :category, :identifier
  json.url team_url(team, format: :json)
end
