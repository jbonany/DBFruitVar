class PhenologyRecord < ActiveRecord::Base
  belongs_to :block

  self.per_page = 15


	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |phenology_record|
      			csv << phenology_record.attributes.values_at(*column_names)
    		end
 		end
	end

end
