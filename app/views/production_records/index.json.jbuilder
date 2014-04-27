json.array!(@production_records) do |production_record|
  json.extract! production_record, :id, :harvest_date, :tree_number, :production, :c90, :c8590, :c8085, :c80, :c7580, :c7275, :c7072, :c6870, :c6568, :c65, :c6065, :c5560, :c55, :block_id
  json.url production_record_url(production_record, format: :json)
end
