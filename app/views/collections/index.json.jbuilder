json.array!(@collections) do |collection|
  json.extract! collection, :id, :name, :row_distance, :tree_distance, :location_id, :species_id
  json.url collection_url(collection, format: :json)
end
