ApdApi::Application.routes.draw do
  get 'crimes/lastyear' => 'crimes#current_year'
  get 'crimes/lastmonth' => 'crimes#current_month'
  get 'crimes/month/:year/:month' => 'crimes#by_month'
  get 'crimes/day/:year/:month/:day' => 'crimes#by_day'
  # get 'crimes/recent' => 'crimes#most_recent'
  # get 'crimes/:id' => 'crimes#show'
  get 'crimes/:field/:value' => 'crimes#by_filter'
  get 'crimes/:field/:value/lastmonth' => 'crimes#by_filter_lastmonth'
  get 'crimes/:field/:value/lastyear' => 'crimes#by_filter_lastyear'
  get 'crimes/:field/:value/:field2/:value2' => 'crimes#by_filter_filter'
  get 'crimes/:field/:value/lastmonth/:field2/:value2' => 'crimes#by_filter_lastmonth_filter'
  get 'crimes/:field/:value/lastyear/:field2/:value2' => 'crimes#by_filter_lastyear_filter'
  get 'zone/:zone' => 'beats#list_beats'
  get 'zone/' => 'beats#all_beats'

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
