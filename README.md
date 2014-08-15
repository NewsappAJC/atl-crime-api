# AJC CRIME API #

Drop current table and set up new table for new crime data
     
    rake db:drop db:create db:migrate

Import new crime data

	rake import


### API Routes available: ###

/crimes/:id

/crimes/current_year

/crimes/current_month

/crimes/month/:year/:month

/crimes/day/:year/:month/:day

/crimes/neighborhood/:neighborhood

/crimes/shift/:shift 	=> morn, eve, day, unk

/crimes/beat/:beat

/crimes/zone/:zone		=> zones 1-6

/crimes/type/:crime
