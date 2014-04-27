class CreateProductionRecords < ActiveRecord::Migration
  def change
    create_table :production_records do |t|
      t.date :harvest_date
      t.integer :tree_number
      t.float :production
      t.float :c90
      t.float :c8590
      t.float :c8085
      t.float :c80
      t.float :c7580
      t.float :c7275
      t.float :c7072
      t.float :c6870
      t.float :c6568
      t.float :c65
      t.float :c6065
      t.float :c5560
      t.float :c55
      t.references :block, index: true

      t.timestamps
    end
  end
end
