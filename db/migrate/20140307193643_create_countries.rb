class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso
      t.string :name
      t.string :nicename
      t.string :iso3
      t.integer :numcode
      t.integer :phonecode

      t.timestamps
    end
  end
end
