json.array!(@stockitems) do |stockitem|
  json.extract! stockitem, :id, :title_de, :title_en, :details_hint, :rate_eur, :rate_interval, :picture
  json.url stockitem_url(stockitem, format: :json)
end
