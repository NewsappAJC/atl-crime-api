class CrimeCount < ActiveRecord::Base

	self.primary_key = :zone_id

	scope :by_zone, lambda { |zone| where('zone_id = ?', zone) }

	def self.zone_time_totals
		crimes = self.find(:all).group_by(&:crime)

		return crimes.map { |m|
			{
				:crime => m[0],
				:crime_type => m[1].map{ |z| z[:crime_detail] }.uniq,
				:max => m[1].map{ |z| z[:count] }.max,
				:min => m[1].map{ |z| z[:count] }.min,
				:zones => m[1].group_by(&:zone_id).map{ |z| z[1[0]] }
			}
		}
	end


end