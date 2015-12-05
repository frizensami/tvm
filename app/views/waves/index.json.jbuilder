json.array!(@waves) do |wafe|
  json.extract! wafe, :id, :wave_number, :start_time
  json.url wafe_url(wafe, format: :json)
end
