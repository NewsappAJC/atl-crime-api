class CrimeSerializer < ActiveModel::Serializer
    attributes :id,
  			   :MI_PRINX, 
  			   :offense_id, 
  			   :rpt_date, 
  			   :occur_date, 
  			   :occur_time, 
  			   :poss_date, 
  			   :poss_time, 
  			   :beat, 
  			   :location, 
  			   :MaxOfnum_victims, 
  			   :Shift, 
  			   :UC2_Literal, 
  			   :neighborhood, 
  			   :x, 
  			   :y, 
  			   :crime, 
  			   :zone, 
  			   :violent

  	belongs_to :beat

end
