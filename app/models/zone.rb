class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key
  has_many :beats
  has_many :crimes

  scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}

  # def self.test
  #   map{ |z| {
  #     { zone: z.zone, population: z.population.to_f, crime_percap: z.crimes.length/z.population.to_f } 
  #   } }
  #   return mapped
  #   # return c.map { |p| {  zone: p.zone, crime: p.crime, beat: p['beat'], zonepop: (c.length/z.population.to_f)  } } 
  # end


  def self.count_crimes
    _zones = find(:all)

    return _zones.map { |z| 
      {
        zone: z.zone,
        population: find_by_zone(z.zone).population,
        total_crime: find_by_zone(z.zone).crimes.length,
        violent: find_by_zone(z.zone).crimes.where(violent:"violent").count
      }
    }

  end

  def self.count_crimes_byzone(zone)
    crimes_in_zone = find_by_zone(zone).crimes

    # grouped = crimes_in_zone
    #   .created_between("1/1/2009".to_date,Time.now)
    
    violent = crimes_in_zone
        .created_between("1/1/2009".to_date,Time.now)
        .where(violent:"violent")
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a

    nonviolent = crimes_in_zone
        .created_between("1/1/2009".to_date,Time.now)
        .where(violent:"nonviolent")
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
    t = crimes_in_zone.group("HOUR(occur_time)").count.to_a

   	return { 
      zone: zone, 
      population: find_by_zone(zone).population,
      total_crime: crimes_in_zone.length,
      violent: violent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } },
      nonviolent: nonviolent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } },
      time_of_day: t.map{ |hour| { :hour => hour[0] , :count => hour[1] } }
    } 
  end

  def crime_list
    self.crimes
  end


end