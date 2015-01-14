class BeatSerializer < ActiveModel::Serializer
  attributes :zone, :beat, :population

  has_many :crimes, :foreign_key => 'beat'
  belongs_to :zone, :foreign_key => 'zone'
  
end
