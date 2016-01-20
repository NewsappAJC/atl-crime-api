class Zone < ActiveRecord::Base
  
  self.primary_key = :zone # or other primary key
  has_many :beats
  has_many :crimes
  has_many :neighborhoods

  #scope :all_zones, -> { where.not("zone = ? or zone = ? or zone = ?", '0', ' ', '9') }
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}


  def self.created_between_count(start_date)
    maxDay = Crime.maximum("occur_date")
    end_date = maxDay - (maxDay.day).day    # subtracts day of the month from last date in database to only Crime entries through last full month of data :)

    return where("occur_date >= ? AND occur_date <= ?", start_date, end_date)
  end

  def self.beat_info(zone)
    beats = find_by_zone(zone).beat_arr
    return beats
  end

  def self.count_crimes_byzone(zone)
    z = find_by_zone(zone)
    crimes_in_zone = z.crimes.time_range('1','month')
    rate = crime_change(z)
    neighborhoods = z.neighborhoods.to_enum(:each_with_index).map{|a,i| "#{a.neighborhood}"}
    return { 
      zone: z.zone,
      population: z.population.to_f,
      neighborhoods: neighborhoods,

      totals: {
        dates: [crimes_in_zone.order("occur_date DESC").first.occur_date, crimes_in_zone.order("occur_date DESC").last.occur_date],
        total_crime: crimes_in_zone.length,
        violent: {
          violent: crimes_in_zone.where('violent'=>'violent').length,
          nonviolent: crimes_in_zone.where('violent'=>'nonviolent').length
        },
        crime_type: crimes_in_zone.group("crime").count
      },
      change: {
        dates: [rate[:lastyear].order("occur_date DESC").first.occur_date, rate[:lastyear].order("occur_date DESC").last.occur_date],
        total_crime: percent_change(rate[:lastyear].length,rate[:lastmonth].length,'crime'),
        violent: percent_change(rate[:lastyear].where('violent'=>'violent').length,rate[:lastmonth].where('violent'=>'violent').length,'violent crime'),
        nonviolent: percent_change(rate[:lastyear].where('violent'=>'nonviolent').length,rate[:lastmonth].where('violent'=>'nonviolent').length,'nonviolent crime')
      }
      # },
      # top_beats: z.top_beats
    }
  end

  def self.all_zones
    zones = self.where.not("zone = ? or zone = ? or zone > ?", '0', ' ', '6')
    return zones.map{ |z|
      {
        zone: z.zone,
        population: z.total_crimes,
        neighborhoods: z.neighborhoods.to_enum(:each_with_index).map{|a,i| "#{a.neighborhood}"}
      }
    }

  end

  def self.zone_beats(zone)
    z = find_by_zone(zone)
    crimes_in_zone = z.crimes
    max = Crime.maximum(:occur_date)
    min = DateTime.new(2009)

    range = ((max - min) / 1.year)
    return z.beats.map{ |b|
        {
          beat: b.beat,
          total_crimes: b.total_crimes,
          population: b.population.to_f,
          crimes_percap: (b.total_crimes/b.population.to_f)/range
        }
      }
  end

  def self.map_crimes(zone)
    z = find_by_zone(zone)
    crimes_in_zone = z.crimes
    return crimes_in_zone.time_range('1','month')
  end


  def self.filter(zone)
    z = find_by_zone(zone)
    violent = z.crime_list('violent','violent')
    nonviolent = z.crime_list('violent','nonviolent')
    t = z.crimes.group("HOUR(occur_time)").count.to_a
    group_crimes = z.crimes
        .created_between_count("1/1/2009".to_date)
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
        .created_between_count("1/1/2009".to_date)
        .where("#{field} = ?", value)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
  end


  def self.crime_change(z)
    last_crime = Crime.select(:occur_date).order("occur_date DESC").first.occur_date
    last_month = last_crime - last_crime.day.days
    return {
      lastyear: z.crimes.where("occur_date >= ? AND occur_date <= ?", last_month - 2.month, last_month-1.month ),
      lastmonth: z.crimes.where("occur_date >= ? AND occur_date <= ?", last_month - 1.month, last_month )
    }
  end

  def self.percent_change(oldnum,newnum,crime)
    change = newnum.to_f-oldnum.to_f
    if change<0
      newchange = change*-1
      perc = ((newchange/oldnum)*100).round(2)
      return {
        oldnum: oldnum,
        newnum: newnum,
        percent: '-'+perc.to_s+'%',
        text: 'Last month saw ' + perc.to_s + '% fewer '+ crime + ' incidents than the month before.'
      }
    else
      perc = ((change/oldnum)*100).round(2)
      return {
        oldnum: oldnum,
        newnum: newnum,
        percent:'+'+perc.to_s+'%',
        text: 'Last month saw ' + perc.to_s + '% more '+ crime + ' incidents than the month before.'
      }
    end

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