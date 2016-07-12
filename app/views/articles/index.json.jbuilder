json.array!(@articles) do |article|
  json.extract! article, :id, :title, :details, :price_eur, :rate, :gratis, :deposit_eur, :location_id, :user_id
  json.url article_url(article, format: :json)
end
