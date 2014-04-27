json.array!(@collections) do |collection|
  json.extract! collection, :name
  json.latitude collection.location.latitude
  json.longitude collection.location.longitude
end
