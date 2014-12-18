class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key
  has_many :crimes
  has_many :beats

  scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }


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
  	crime = Crime.where("zone = ? AND occur_date >= ? AND occur_date <= ?",zone, start_date, end_date ).group("YEAR(occur_date)").count.to_a
   	pop = Beat.where("zone = ?", zone)
   	c = crime.each_with_index.map { |date,i| {:date => date[0].to_s, :count => (date[1].to_f)/(pop[i].population.to_f) }  }
   	return pop.map { |p| 
   		{ beat: p.beat, 
   		  population: p.population, 
   		  zone: p.zone, 
   		  crime: Crime.where("beat = ? AND occur_date >= ? AND occur_date <= ?",p.beat, start_date, end_date ).group("YEAR(occur_date)").count
   		} 
	}
  end

end