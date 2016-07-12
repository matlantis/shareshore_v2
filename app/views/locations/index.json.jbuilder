json.array!(@locations) do |location|
  json.extract! location, :id, :street_and_no, :postcode, :city, :country, :user_id
  json.url location_url(location, format: :json)
end
