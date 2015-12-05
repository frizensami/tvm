json.array!(@ranks) do |rank|
  json.extract! rank, :id, :rank, :end_time
  json.url rank_url(rank, format: :json)
end
