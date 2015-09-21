json.array!(@locations) do |location|
  json.extract! location, :id, :lat, :lon, :emailed_at
end
