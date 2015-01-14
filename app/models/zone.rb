class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key
  # has_many :crimes
  has_many :beats, :foreign_key => 'zone'
  has_many :crimes, :through => :beats, :foreign_key => 'zone'

  scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }

  def self.test(zone)
    z = find_by_zone(zone)
    c = z.crimes
    return c.map { |p| {  zone: p.zone, crime: p.crime, beat: p['beat'], zonepop: (c.length/z.population.to_f)  } } 
  end


  def self.count_crimes
  	start_date = "1/1/2009".to_date
  	end_date = Time.now
  	crime = Crime.where("occur_date >= ? AND occur_date <= ?",start_date, end_date ).group("YEAR(occur_date)").count.to_a
   	pop = pluck(:population)
   	zone = pluck(:zone)
   	c = crime.each_with_index.map { |date,i| {:date => date[0].to_s, :count => (date[1].to_f)/(pop[i].to_f) }  }
   	return pop.each_with_index.map { |p,i| { zone: zone[i], population: p, crime: c } }
  end

  def self.count_crimes_byzone(zone)
  	start_date = "1/1/2009".to_date
  	end_date = Time.now
    #beats = Zone.find_by_zone(zone).beats
    Zone.find_by_zone(zone).crimes


     #.where("zone = ? AND occur_date >= ? AND occur_date <= ?",zone.zone, start_date, end_date ).group("YEAR(occur_date)")
   	#pop = Beat.where("zone = ?", zone)
   # 	c = crime.each_with_index.map { |date,i| {:date => date[0].to_s, :count => (date[1].to_f)/(pop[i].population.to_f) }  }
   # 	return pop.map { |p| 
   # 		{ beat: p.beat, 
   # 		  population: p.population, 
   # 		  zone: p.zone, 
   # 		  crime: crime
   # 		} 
	  # }
  end

  def crime_list
    self.crimes
  end

  def active_model_serilaizer
    ZoneSerializer
  end

end