class ZoneCount < ActiveRecord::Base

	self.primary_key = :zone 
	has_one :crime
	scope :all_zones

end
