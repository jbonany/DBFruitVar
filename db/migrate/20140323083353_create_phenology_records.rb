class CreatePhenologyRecords < ActiveRecord::Migration
  def change
    create_table :phenology_records do |t|
      t.date :year
      t.date :c3
      t.date :e2
      t.date :f2
      t.date :g
      t.references :block, index: true

      t.timestamps
    end
  end
end
