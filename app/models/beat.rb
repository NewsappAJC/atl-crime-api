class Beat < ActiveRecord::Base
  
  self.primary_key = :beat # or other primary key
  belongs_to :zone
  has_many :crimes


  scope :list_beats, lambda { |zone| where('zone = ?', zone) }
  scope :all_beats


end