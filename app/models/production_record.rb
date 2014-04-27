class ProductionRecord < ActiveRecord::Base
  belongs_to :block

  self.per_page = 15

  def year_production
  	self.harvest_date.year - self.block.planting_date.year + 1
  end

	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |production_record|
      			csv << production_record.attributes.values_at(*column_names)
    		end
 		end
	end

  def self.filtered_by_collection(selected_collection)

    if selected_collection == "None"
      all
    else
      joins(:block).where(blocks: {collection_id: selected_collection.to_i})
    end

  end

end
