# AJC CRIME API #

Set up new table for new crime data
     
    rake db:migrate

Import new crime data

	rake csv


### API Routes available: ###

'/' => 'crimes#count_city'
'filter' => 'crimes#filter_city'
'beat-details' => 'crimes#city_beats'
'compare' => 'crimes#citywide_comp'
'lastday' => 'crimes#lastday'

'/counts' => 'crime_counts#zone_totals'

'zones/' => 'zones#all_zones'
'zone/:zone' => 'zones#this_zone'
'zone/:zone/map' => 'zones#zone_map'
'zone/:zone/beat-details' => 'zones#beats'
'zone/:zone/filter' => 'zones#filter_zone'


'beat/' => 'beats#beat_crime'
'beat/:beat' => 'beats#beat_crimes'
'beat/:beat/map' => 'beats#beat_map'
'beat/:beat/filter' => 'beats#filter_beat'
'neighborhoods/list/beats' => 'neighborhoods#beat_group'
'neighborhoods/list/zones' => 'neighborhoods#zone_group'

