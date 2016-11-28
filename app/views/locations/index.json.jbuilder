json.array!(@locations) do |location|
  json.extract! location, :id, :street, :number, :postcode, :city, :country, :user_id
  json.url location_url(location, format: :json)
end
