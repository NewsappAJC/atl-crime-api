class ZoneSerializer < ActiveModel::Serializer
  attributes 	:zone, 
  				:population,
  				:crimes,
  				:crime_rate

  has_many :beats, :foreign_key => 'zone'
  has_many :crimes, :through => :beats, :foreign_key => 'zone'

  def crimes
  	object.crime_list
  end

  def crime_rate
  	object.crimes.length/object.population
  end

end