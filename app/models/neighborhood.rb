class Neighborhood < ActiveRecord::Base

	self.primary_key = :neighborhood # or other primary key
  	belongs_to :zone
  	belongs_to :beat
  	has_many :crimes

end
