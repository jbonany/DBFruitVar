class Group < ActiveRecord::Base
  
  belongs_to :species
  has_many :groups

  self.per_page = 15

  def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |group|
      			csv << group.attributes.values_at(*column_names)
    		end
 		end
  end

end
