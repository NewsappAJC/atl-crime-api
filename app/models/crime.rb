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

  scope :by_month, -> (year, month) { where("month(occur_date) = #{month} and year(occur_date) = #{year}")}
  scope :by_day, -> (year, month, day) { where("month(occur_date) = #{month} and year(occur_date) = #{year} and day(occur_date) = #{day}")}
  scope :current_year, -> { where("year(occur_date) = year(current_date())")}
  scope :current_month, -> { where("month(occur_date) = month(current_date()) and year(occur_date) = year(current_date())")}
  scope :by_hood, lambda { |neighborhood| where('neighborhood = ?', neighborhood) }
  scope :by_beat, lambda { |beat| where('beat = ?', beat) }
  scope :by_shift, lambda { |shift| where('shift = ?', shift) }
  scope :by_crime, lambda { |crime| where('crime = ?', crime) }
  scope :by_zone, lambda { |zone| where('zone = ?', zone) }

  scope :beat_hoods, lambda { |beat| where('beat = ?', beat) }

  # scope :by_weekday, -> (weekday) { where("weekday(occur_date) = #{weekday}")}


  def self.by_month
    now = Date.new
    month = now.month
    year = now.year
    self.by_month(year, month)
  end

end
