class Block < ActiveRecord::Base
  belongs_to :collection
  belongs_to :accession
  has_many :phenology_records
  has_many :production_records

  self.per_page = 15

  def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |block|
      			csv << block.attributes.values_at(*column_names)
    		end
 		end
  end

  def self.filtered_by_collection(selected_collection)

    if selected_collection == "None"
      all
    else
      where("collection_id = ?", selected_collection.to_i)
    end

  end

end

