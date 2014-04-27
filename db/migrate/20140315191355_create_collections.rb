class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.decimal :row_distance
      t.decimal :tree_distance
      t.references :location, index: true
      t.references :species, index: true

      t.timestamps
    end
  end
end
