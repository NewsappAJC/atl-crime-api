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


  def self.by_month
    now = Date.new
    month = now.month
    year = now.year
    self.by_month(year, month)
  end


  def self.violent_crimes

    { violent: where(violent: 1).count(group: :occur_date).to_a  ,
     nonviolent: where(violent: 0).count(group: :occur_date).to_a  }
  end



end
