class Accession < ActiveRecord::Base
  
  belongs_to :species
  belongs_to :group

  has_many :blocks

  self.per_page = 15

  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
   		csv << column_names
   		all.each do |product|
  			csv << product.attributes.values_at(*column_names)
   		end
 	  end
  end
	
end
