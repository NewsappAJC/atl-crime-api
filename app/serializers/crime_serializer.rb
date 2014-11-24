class CrimeSerializer < ActiveModel::Serializer
  	attributes :id, :zone, :crime, :violent, :occur_date#, count(:violent)
end
