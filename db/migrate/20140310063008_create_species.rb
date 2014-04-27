class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :name
      t.string :latinname
      t.string :acronym

      t.timestamps
    end
  end
end
