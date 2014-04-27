class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.integer :tree
      t.integer :row
      t.date :planting_date
      t.date :pullout_date
      t.string :rootstock
      t.integer :oldcode
      t.integer :oldaccessioncode
      t.integer :oldcollectioncode
      t.references :block, index: true

      t.timestamps
    end
  end
end
