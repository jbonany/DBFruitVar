json.array!(@trees) do |tree|
  json.extract! tree, :id, :tree, :row, :planting_date, :pullout_date, :rootstock, :oldcode, :oldaccessioncode, :oldcollectioncode, :block_id
  json.url tree_url(tree, format: :json)
end
