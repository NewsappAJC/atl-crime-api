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

  validates_uniqueness_of :offense_id

  scope :by_month, -> (year, month) { where("month(occur_date) = #{month} and year(occur_date) = #{year}")}
  scope :by_day, -> (year, month, day) { where("month(occur_date) = #{month} and year(occur_date) = #{year} and day(occur_date) = #{day}")}
  scope :current_year, -> { where("year(occur_date) = year(current_date())")}
  scope :current_month, -> { where("month(occur_date) = month(current_date()) and year(occur_date) = year(current_date())")}
  scope :by_beat, lambda { |beat| where('beat = ?', beat) }
  scope :by_shift, lambda { |shift| where('shift = ?', shift) }
  scope :by_crime, lambda { |crime| where('crime = ?', crime) }
  scope :by_zone, lambda { |zone| where('zone = ?', zone) }
  scope :by_filter, -> (field, value) { where("#{field} = ?", value) }
  scope :created_between, lambda {|start_date, end_date| where("occur_date >= ? AND occur_date <= ?", start_date, end_date )}
  ( "text_value <> ''" )
 
  def self.by_month
    now = Date.new
    month = now.month
    year = now.year
    self.by_month(year, month)
  end


  def self.crime_count
    crime = group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    return crime.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] }  }
  end

  def self.violent_count
    v = where(violent: "violent").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    nv = where(violent: "nonviolent").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    return { violent: v.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , nonviolent: nv.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] }  } }
  end

  def self.shift_count
    morn = where(shift: "morn").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    day = where(shift: "day").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    eve = where(shift: "eve").group("YEAR(occur_date)").group("MONTH(occur_date)").count.to_a
    return { morning: morn.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , day: day.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } , evening: eve.map { |date| {:date => date[0][1].to_s+'/'+date[0][0].to_s, :count => date[1] } } }
  end

  def self.time_of_day
    t = count(group: "HOUR(occur_time)").to_a
    return t.map{ |hour| { :hour => hour[0] , :count => hour[1] } }
  end

  def self.count_zones
    z = where.not(:zone => ['', 0, 9]).group(:zone)
    x = z.map{ |zone| { zone: zone['zone'], count: zone } }
   # z = where.not(:zone => ['', 0, 9]).group(:zone).inject.group(["YEAR(occur_date)","MONTH(occur_date)"]).count.to_a
   # z = z.map { |zone| { zone: zone[0][0], month: zone[0][2].to_s+'/'+zone[0][1].to_s, count: zone[1] } }
   # output = z.uniq{|x| x['zone'] }
    return z
  end



end
