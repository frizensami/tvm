json.array!(@teams) do |team|
  json.extract! team, :id, :category
  json.url team_url(team, format: :json)
end
