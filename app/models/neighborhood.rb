class Neighborhood < ActiveRecord::Base

	self.primary_key = :neighborhood # or other primary key
 	scope :list_hoods, lambda { |zone| where('zone = ?', zone) }

  	def self.all_hoods
  		h = where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9')
  		return h
  	end

end
