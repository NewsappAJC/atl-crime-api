# AJC CRIME API #

Drop current table and set up new table for new crime data
     
    rake db:drop db:create db:migrate

Import new crime data

	rake import


### API Routes available: ###

/crimes/current_year' -> this year

/crimes/current_month' -> this month

/crimes/month/:year/:month' -> specific month

/crimes/day/:year/:month/:day' -> specific day

/crimes/:id' -> by id

/crimes/:field/:value'

/crimes/:field/:value/thismonth'

/crimes/:field/:value/thisyear'

/crimes/:field/:value/:field2/:value2'

/crimes/:field/:value/thismonth/:field2/:value2'

/crimes/:field/:value/thisyear/:field2/:value2'

