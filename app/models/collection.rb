class Collection < ActiveRecord::Base
  belongs_to :location
  belongs_to :species
  has_many :blocks

  self.per_page = 15

  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
   		csv << column_names
   		all.each do |collection|
  			csv << collection.attributes.values_at(*column_names)
   		end
 	  end
  end

  def self.filtered_by_collection(selected_collection)

    if selected_collection == "None"
      all
    else
      where("id = ?", selected_collection.to_i)
    end

  end

  
end
