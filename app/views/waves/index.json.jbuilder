json.array!(@waves) do |wave|
  json.extract! wave, :id, :wave_number, :start_time
  json.url wave_url(wave, format: :json)
end
