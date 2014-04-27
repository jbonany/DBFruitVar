json.array!(@countries) do |country|
  json.extract! country, :id, :iso, :name, :nicename, :iso3, :numcode, :phonecode
  json.url country_url(country, format: :json)
end
