ApdApi::Application.routes.draw do
  get 'crimes/lastyear' => 'crimes#last_year'
  get 'crimes/lastmonth' => 'crimes#last_month'
  get 'crimes/month/:year/:month' => 'crimes#by_month'
  get 'crimes/day/:year/:month/:day' => 'crimes#by_day'
  get 'crimes/recent' => 'crimes#most_recent'
  # get 'crimes/:id' => 'crimes#show'
  get 'crimes/filter/:field/:value' => 'crimes#by_filter'

  # time range
  get 'crimes/all/:timeperiod/:timeval' => 'crimes#by_timerange'
  get 'crimes/count-zone/:timeperiod/:timeval' => 'crimes#count_zone'
  get 'crimes/count-beat/:timeperiod/:timeval' => 'crimes#count_beat'
  get 'crimes/filter/:field/:value/:timeperiod/:timeval' => 'crimes#by_filter_timerange'

  # counts # of crimes by date grouped by attribute
  get 'crimes/test-pop/:zone' => 'crimes#test'
  get 'crimes/lastdate' => 'crimes#lastdate'

  get 'crimes/count' => 'crimes#countall'
  get 'crimes/violent' => 'crimes#countviolent'
  get 'crimes/time' => 'crimes#counttime'
  get 'crimes/filter/:field/:value/count' => 'crimes#by_filter_countall'
  get 'crimes/filter/:field/:value/violent' => 'crimes#by_filter_countviolent'
  #get 'crimes/:field/:value/shift' => 'crimes#by_filter_countshift'
  get 'crimes/filter/:field/:value/time' => 'crimes#by_filter_time'

  get 'crimes/top/:group/violent' => 'crimes#top_violent'
  get 'crimes/top/:group/nonviolent' => 'crimes#top_nonviolent'
  get 'crimes/top/:group' => 'crimes#top_list'


  get 'crimes/all' => 'crimes#citywide_comp'


  get '/' => 'crimes#count_city'
  get '/filter' => 'crimes#filter_city'
  get '/map' => 'crimes#map_city'

  #zones subview
  get 'zones/' => 'zones#all_zones'
  get 'zone/:zone' => 'zones#this_zone'
  get 'zone/:zone/map' => 'zones#zone_map'
  get 'zone/:zone/beat-details' => 'zones#beats'
  get 'zone/:zone/filter' => 'zones#filter_zone'


  get 'zone/' => 'zones#show_all_crimes'

  get 'beat/' => 'beats#beat_crime'
  get 'beat/:beat' => 'beats#beat_crimes'
  get 'beat/:beat/map' => 'beats#beat_map'
  get 'beat/:beat/filter' => 'beats#filter_beat'


  # resources :crimes, except: [:new, :edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
