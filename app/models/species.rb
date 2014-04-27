class Species < ActiveRecord::Base
	
	has_many :groups
	has_many :collections
	has_many :accessions

	self.per_page = 15

	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |species|
      			csv << species.attributes.values_at(*column_names)
    		end
 		end
	end
	
end
