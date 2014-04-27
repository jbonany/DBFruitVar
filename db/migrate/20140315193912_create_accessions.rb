class CreateAccessions < ActiveRecord::Migration
  def change
    create_table :accessions do |t|
      t.string :name
      t.string :commercial_name
      t.string :clon_name
      t.string :synonims
      t.integer :oldcode
      t.references :species, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
