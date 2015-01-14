class Beat < ActiveRecord::Base
  
  self.primary_key = :beat # or other primary key
  has_many :crimes, :foreign_key => 'beat'
  belongs_to :zone, :foreign_key => 'zone'


  scope :list_beats, lambda { |zone| where('zone = ?', zone) }
  scope :all_beats


end