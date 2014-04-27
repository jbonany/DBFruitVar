class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :row
      t.integer :first_tree
      t.integer :last_tree
      t.integer :tree_number
      t.date :planting_date
      t.date :pullout_date
      t.references :collection, index: true
      t.references :accession, index: true

      t.timestamps
    end
  end
end
