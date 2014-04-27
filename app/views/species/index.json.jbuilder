json.array!(@species) do |species|
  json.extract! species, :id, :name, :latinname, :acronym
  json.url species_url(species, format: :json)
end
