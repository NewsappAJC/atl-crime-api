ApdApi::Application.routes.draw do
  get '/' => 'crimes#count_city'
  get 'filter' => 'crimes#filter_city'
  get 'beat-details' => 'crimes#city_beats'
  get 'compare' => 'crimes#citywide_comp'
  get 'lastday' => 'crimes#lastday'
  # get '/map' => 'zones#show_all_crimes'

  #zones subview
  get 'zones/' => 'zones#all_zones'
  get 'zone/:zone' => 'zones#this_zone'
  get 'zone/:zone/map' => 'zones#zone_map'
  get 'zone/:zone/beat-details' => 'zones#beats'
  get 'zone/:zone/filter' => 'zones#filter_zone'


  get 'beat/' => 'beats#beat_crime'
  get 'beat/:beat' => 'beats#beat_crimes'
  get 'beat/:beat/map' => 'beats#beat_map'
  get 'beat/:beat/filter' => 'beats#filter_beat'
end
