class Location < ActiveRecord::Base

	has_many :collections

	self.per_page = 15
	
	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |location|
      			csv << location.attributes.values_at(*column_names)
    		end
 		end
	end

end
