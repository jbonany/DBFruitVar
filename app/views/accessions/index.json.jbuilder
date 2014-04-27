json.array!(@accessions) do |accession|
  json.extract! accession, :id, :name, :commercial_name, :clon_name, :synonims, :oldcode, :species_id, :group_id
  json.url accession_url(accession, format: :json)
end
