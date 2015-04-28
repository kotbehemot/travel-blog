json.array!(@places) do |place|
  json.extract! post, :id, :name
  json.url admin_place_url(place, format: :json)
end
