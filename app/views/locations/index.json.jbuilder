json.array!(@locations) do |location|
  json.extract! location, :id, :address, :user_id
  json.url location_url(location, format: :json)
end
