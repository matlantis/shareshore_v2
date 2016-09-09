json.array!(@templates) do |template|
  json.extract! template, :id, :title, :details_hint, :rate_eur, :rate_interval, :picture
  json.url template_url(template, format: :json)
end
