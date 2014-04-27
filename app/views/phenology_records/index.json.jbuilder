json.array!(@phenology_records) do |phenology_record|
  json.extract! phenology_record, :id, :year, :c3, :e2, :f2, :g, :block_id
  json.url phenology_record_url(phenology_record, format: :json)
end
