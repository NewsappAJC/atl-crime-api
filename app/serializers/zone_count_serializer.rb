class ZoneCountSerializer < ActiveModel::Serializer
	attributes :id,
	  			:zone,
	  			:crimes


  	# def crimes
  	# 	{
  	# 		date: object.occur_date
  	# 		count: where(zone: object.zone).group("YEAR(object.occur_date)").group("MONTH(object.occur_date)").count
  	# 	}
  	# end

end
