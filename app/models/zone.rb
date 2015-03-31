class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key
  has_many :beats
  has_many :crimes

  scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}

  def self.count_crimes
    _zones = find(:all)

    return _zones.map { |z| 
      {
        zone: z.zone,
        population: find_by_zone(z.zone).population.to_f,
        total_crime: find_by_zone(z.zone).crimes.length,
        violent: find_by_zone(z.zone).crimes.where(violent:"violent").count
      }
    }

  end

  def self.beat_info(zone)
    beats = find_by_zone(zone).beat_arr
    return beats
  end

  def self.count_crimes_byzone(zone)
    z = find_by_zone(zone)
    crimes_in_zone = z.crimes
   	return { 
      zone: z.zone,
      population: z.population.to_f,
      totals: {
        total_crime: crimes_in_zone.length,
        violent: {
          violent: crimes_in_zone.where('violent'=>'violent').length,
          nonviolent: crimes_in_zone.where('violent'=>'nonviolent').length
        },
        crime_type: crimes_in_zone.created_between("1/1/2009".to_date,Time.now).group("crime").count
      }
      # },
      # top_beats: z.top_beats
    }
  end

  def self.map_crimes(zone)
    z = find_by_zone(zone)
    crimes_in_zone = z.crimes
    return { 
      beats: z.beats.map{ |b|
        {
          beat: b.beat,
          total_crimes: b.crimes.length,
          crimes_percap: b.crimes.length/b.population.to_f
        }
      },
      crimes: crimes_in_zone.time_range('2','week')
    }

  end

  def self.filter(zone)
    z = find_by_zone(zone)
    violent = z.crime_list('violent','violent')
    nonviolent = z.crime_list('violent','nonviolent')
    z = find_by_zone(zone)
    t = z.crimes.group("HOUR(occur_time)").count.to_a
    group_crimes = z.crimes
        .created_between("1/1/2009".to_date,Time.now)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a

    return {
      all: group_crimes.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } },
      violent_count: {
        violent: violent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } },
        nonviolent: nonviolent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } },
      },
      time: t.map{ |hour| { :hour => hour[0] , :count => hour[1]/(z.population.to_f/100) } }
    }

  end

  def self.all_crime(zone)
    z = find_by_zone(zone)
    group_crimes = z.crimes
        .created_between("1/1/2009".to_date,Time.now)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
    return group_crimes.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } }
  end

  def self.violent_filter(zone)
    z = find_by_zone(zone)
    violent = z.crime_list('violent','violent')
    nonviolent = z.crime_list('violent','nonviolent')
    return {
      violent: violent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } },
      nonviolent: nonviolent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(z.population.to_f/100) } }
    }
  end

  def self.hours_filter(zone)
    z = find_by_zone(zone)
    t = z.crimes.group("HOUR(occur_time)").count.to_a
    return t.map{ |hour| { :hour => hour[0] , :count => hour[1]/(z.population.to_f/100) } }
  end


  def time_range(timeval,timeperiod)
    t = timeval.to_i
    end_date = Crime.select(:occur_date).order("occur_date DESC").first.occur_date
    if timeperiod === 'week'
      start_date = end_date - t.week
    end
    if timeperiod === 'day'
      start_date = end_date - t.day
    end
    if timeperiod === 'month'
      start_date = end_date - t.month
    end
    if timeperiod === 'year'
      start_date = end_date - t.year
    end
    return self.where("occur_date >= ? AND occur_date <= ?", start_date, end_date )
  end

  def crime_list(field,value)
    self.crimes
        .created_between("1/1/2009".to_date,Time.now)
        .where("#{field} = ?", value)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
  end

  def top_beats
    arr = self.beats.sort! { |a,b| b.crimes.length/b.population.to_f <=> a.crimes.length/a.population.to_f }.first(3)

    return arr.map{ |b|
      {
        beat: b.beat,
        crimes_percap: b.crimes.length/b.population.to_f
      }
    }

  end

end