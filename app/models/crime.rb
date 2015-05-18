# == Schema Information
#
# Table name: crimes
#
#  id               :integer          not null, primary key
#  offense_id       :integer
#  rpt_date         :date
#  occur_date       :date
#  occur_time       :time
#  poss_date        :date
#  poss_time        :time
#  beat             :integer
#  location         :string(255)
#  MaxOfnum_victims :integer
#  Shift            :string(255)
#  UC2_Literal      :string(255)
#  neighborhood     :string(255)
#  x                :integer
#  y                :integer
#  created_at       :datetime
#  updated_at       :datetime
# 

class Crime < ActiveRecord::Base

  validates_uniqueness_of :crime_id, :presence => true
  belongs_to :zone
  belongs_to :beat



  scope :by_month, -> (year, month) { where("month(occur_date) = #{month} and year(occur_date) = #{year}")}
  scope :by_day, -> (year, month, day) { where("month(occur_date) = #{month} and year(occur_date) = #{year} and day(occur_date) = #{day}")}
  scope :current_year, -> { where("year(occur_date) = year(current_date())")}
  scope :current_month, -> { where("month(occur_date) = month(current_date()) and year(occur_date) = year(current_date())")}
  scope :by_beat, lambda { |beat| where('beat = ?', beat) }
  scope :by_shift, lambda { |shift| where('shift = ?', shift) }
  scope :by_crime, lambda { |crime| where('crime = ?', crime) }
  scope :by_zone, lambda { |zone| where('zone_id = ?', zone) }
  scope :by_filter, -> (field, value) { where("#{field} = ?", value) }
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}


  def self.time_range(timeval,timeperiod)
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

  def self.count_crimes
    crimes_in_city = time_range('1','month')
    return { 
      population: 447841,
      totals: {
        total_crime: crimes_in_city.length,
        violent: {
          violent: crimes_in_city.where('violent'=>'violent').length,
          nonviolent: crimes_in_city.where('violent'=>'nonviolent').length
        },
        crime_type: crimes_in_city.group("crime").count
      }
    }
  end

  # def self.map_crimes
  #   return self.time_range('1','month')
  # end

  def crime_list(field,value)
    self.created_between("1/1/2009".to_date,Time.now)
        .where("#{field} = ?", value)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
  end

  def self.created_between_count(start_date)
    maxDay = Crime.maximum("occur_date")
    end_date = maxDay - (maxDay.day).day    # subtracts day of the month from last date in database to only Crime entries through last full month of data :)

    return where("occur_date >= ? AND occur_date <= ?", start_date, end_date)
  end

  def self.filter_crimes
    pop = 447841/100
    violent = crime_list('violent','violent')
    nonviolent = crime_list('violent','nonviolent')
    t = group("HOUR(occur_time)").count.to_a
    #crime = Crime.group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    group_crimes = created_between_count("1/1/2009".to_date)
        .group("YEAR(occur_date)")
        .group("MONTH(occur_date)")
        .count.to_a
    return {
      all: group_crimes.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/pop } },
      violent_count: {
        violent: violent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/pop } },
        nonviolent: nonviolent.map { |date| { :date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/pop } },
      },
      time: t.map{ |hour| { :hour => hour[0] , :count => hour[1]/pop } }
    }
  end









# old models
  def self.filter
    pop = 447841/100
    crime = Crime.group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    return crime.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1]/pop.to_f }  }
  end




  # def self.created_between_count(start_date)
  #   maxDay = Crime.maximum("occur_date")
  #   end_date = maxDay - (maxDay.day).day    # subtracts day of the month from last date in database to only Crime entries through last full month of data :)

  #   return where("occur_date >= ? AND occur_date <= ?", start_date, end_date)
  # end


  # def self.by_month
  #   now = Date.new
  #   month = now.month
  #   year = now.year
  #   self.by_month(year, month)
  # end

  # def self.time_range(timeval,timeperiod)
  #   t = timeval.to_i
  #   end_date = select(:occur_date).order("occur_date DESC").first.occur_date
  #   if timeperiod === 'week'
  #     start_date = end_date - t.week
  #   end
  #   if timeperiod === 'day'
  #     start_date = end_date - t.day
  #   end
  #   if timeperiod === 'month'
  #     start_date = end_date - t.month
  #   end
  #   if timeperiod === 'year'
  #     start_date = end_date - t.year
  #   end
  #   d = where("occur_date >= ? AND occur_date <= ?", start_date, end_date )
  #   return d
  # end

  # def self.mostcrime(group)
  #   if group==='zone'
  #     top = group("zone").count.to_a
  #     return top.map { |t| { :zone =>t[0], :count => t[1] } }
  #   end
  #   if group==='beat'
  #     top = group("beat").count.to_a
  #     return top.map { |t| { :beat =>t[0], :count => t[1] } }
  #   end
  # end

  # def self.mostviolent(group)
  #   if group==='zone'
  #     top = where(violent: "violent").group("zone").count.to_a
  #     return top.map { |t| { :zone =>t[0], :count => t[1] } }
  #   end
  #   if group==='beat'
  #     top = where(violent: "violent").group("beat").count.to_a
  #     return top.map { |t| { :beat =>t[0], :count => t[1] } }
  #   end
  # end

  # def self.mostnonviolent(group)
  #   if group==='zone'
  #     top = where(violent: "nonviolent").group("zone").count.to_a
  #     return top.map { |t| { :zone =>t[0], :count => t[1] } }
  #   end
  #   if group==='beat'
  #     top = where(violent: "nonviolent").group("beat").count.to_a
  #     return top.map { |t| { :beat =>t[0], :count => t[1] } }
  #   end
  # end


  # def self.crime_count
  #   crime = group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   return crime.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] }  }
  # end

  # def self.violent_count
  #   v = where(violent: "violent").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   nv = where(violent: "nonviolent").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   return { violent: v.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , nonviolent: nv.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] }  } }
  # end

  # def self.shift_count
  #   morn = where(shift: "morn").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   day = where(shift: "day").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   eve = where(shift: "eve").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
  #   return { morning: morn.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , day: day.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , evening: eve.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } }
  # end

  # def self.time_of_day
  #   t = count(group: "HOUR(occur_time)").to_a
  #   return t.map{ |hour| { :hour => hour[0] , :count => hour[1] } }
  # end

  # def self.count_zones
  #   z = where.not(:zone => ['', 0, 9]).group(:zone)
  #   x = z.map{ |zone| { zone: zone['zone'], count: zone } }
  #  # z = where.not(:zone => ['', 0, 9]).group(:zone).inject.group(["YEAR(occur_date)","MONTH(occur_date)"]).count.to_a
  #  # z = z.map { |zone| { zone: zone[0][0], month: zone[0][2].to_s+'/'+zone[0][1].to_s, count: zone[1] } }
  #  # output = z.uniq{|x| x['zone'] }
  #   return z
  # end


  



end
