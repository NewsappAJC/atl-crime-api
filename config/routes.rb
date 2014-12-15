ApdApi::Application.routes.draw do
  get 'crimes/lastyear' => 'crimes#last_year'
  get 'crimes/lastmonth' => 'crimes#last_month'
  get 'crimes/month/:year/:month' => 'crimes#by_month'
  get 'crimes/day/:year/:month/:day' => 'crimes#by_day'
  get 'crimes/recent' => 'crimes#most_recent'
  # get 'crimes/:id' => 'crimes#show'
  get 'crimes/:field/:value' => 'crimes#by_filter'
  #get 'crimes/:field/:value/twomonth' => 'crimes#by_filter_twomonth'
  #get 'crimes/:field/:value/sixmonth' => 'crimes#by_filter_sixmonth'
  #get 'crimes/:field/:value/:field2/:value2' => 'crimes#by_filter_filter'
  #get 'crimes/:field/:value/twomonth/:field2/:value2' => 'crimes#by_filter_twomonth_filter'
  #get 'crimes/:field/:value/sixmonth/:field2/:value2' => 'crimes#by_filter_sixmonth_filter'

  # time range
  get 'crimes/:timeperiod/:timeval' => 'crimes#by_timerange'
  get 'crimes/:field/:value/:timeperiod/:timeval' => 'crimes#by_filter_timerange'

  # counts # of crimes by date grouped by attribute
  get 'crimes/:field/:value/count' => 'crimes#by_filter_countall'
  get 'crimes/:field/:value/violent' => 'crimes#by_filter_countviolent'
  get 'crimes/:field/:value/shift' => 'crimes#by_filter_countshift'
  get 'crimes/:field/:value/time' => 'crimes#by_filter_time'


  # crimes grouped by zone, counted by month within
  # get 'crimes/by_zones' => 'crimes#by_zones'

  #zones subview
  get 'zones/' => 'zones#all_zones'
  get 'zone/:zone' => 'beats#list_beats'

  get 'zones/test' => 'zone_counts#all_zones'

  get 'neighborhoods/zone' => 'neighborhood#zone_hoods'
  get 'neighborhoods/beat' => 'neighborhood#beat_hoods'

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
