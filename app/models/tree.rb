class Tree < ActiveRecord::Base
  
  	belongs_to :block

    self.per_page = 15

  	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |tree|
      			csv << tree.attributes.values_at(*column_names)
    		end
      end
 		end
  	
end
