class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :species, index: true

      t.timestamps
    end
  end
end
