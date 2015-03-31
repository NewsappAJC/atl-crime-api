class Beat < ActiveRecord::Base
  
  self.primary_key = :beat # or other primary key
  belongs_to :zone
  has_many :crimes

  scope :list_beats, lambda { |zone| where('zone = ?', zone) }
  scope :all_beats
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}

  def self.count_crimes
    _beats = find(:all)

    return _beats.map { |b| 
      {
        beat: b.beat,
        zone: b.zone_id,
        population: find_by_beat(b.beat).population.to_f,
        total_crime: find_by_beat(b.beat).crimes.length,
        violent: find_by_beat(b.beat).crimes.where(violent:"violent").count
      }
    }

  end

  def self.count_crimes_bybeat(beat)
    crimes_in_beat = find_by_beat(beat).crimes    
    violent = find_by_beat(beat).crime_list('violent','violent')
    nonviolent = find_by_beat(beat).crime_list('violent','nonviolent')
    t = crimes_in_beat.group("HOUR(occur_time)").count.to_a

   	return { 
   	  beat: beat,
      zone: find_by_beat(beat).zone_id, 
      population: find_by_beat(beat).population.to_f,
      total_crime: crimes_in_beat.length,
      violent: { total: crimes_in_beat.where('violent'=>'violent').length, crimes: violent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(find_by_beat(beat).population.to_f/100) } } },
      nonviolent: { total: crimes_in_beat.where('violent'=>'nonviolent').length, crimes: nonviolent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/(find_by_beat(beat).population.to_f/100) } } },
      time_of_day: t.map{ |hour| { :hour => hour[0] , :count => hour[1]/(find_by_beat(beat).population.to_f/100) } }
    } 

  end

  def crime_list(field,value)
    self.crimes
        .created_between("1/1/2009".to_date,Time.now)
        .where("#{field} = ?", value)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
  end


end