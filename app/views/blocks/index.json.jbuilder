json.array!(@blocks) do |block|
  json.extract! block, :id, :row, :first_tree, :last_tree, :tree_number, :planting_date, :pullout_date, :collection_id, :accession_id
  json.url block_url(block, format: :json)
end
