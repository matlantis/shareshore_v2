json.array!(@stockitem_selections) do |stockitem_selection|
  json.extract! stockitem_selection, :id
  json.url stockitem_selection_url(stockitem_selection, format: :json)
end
