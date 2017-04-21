json.array!(@stockitems) do |stockitem|
  json.extract! stockitem, :id, :title_de, :title_en, :details_hint_de, :details_hint_en, :picture
  json.url stockitem_url(stockitem, format: :json)
end
