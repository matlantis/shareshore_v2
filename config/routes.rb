Rails.application.routes.draw do

  resources :houses, only: [:show]

  resources :stockitems

  devise_for :users, controllers: { registrations: "users/registrations" }
  
  root "pages#index"

  get '/search' => 'articles#search', as: 'search_articles'

  resources :articles
  resources :locations, except: [ :new]

  get '/users/:user_id/articles', action: :index_user, controller: 'articles', as: 'articles_user'
  get '/locations/:location_id/articles', action: :index_location, controller: 'articles', as: 'articles_location'
  get '/users/:user_id/locations', action: :index_user, controller: 'locations', as: 'locations_user'

  get '/user/locations', action: :index_owner, controller: 'locations', as: 'user_locations'
  get '/user/articles', action: :index_owner, controller: 'articles', as: 'user_articles'
  get '/user/new_article_from_stockitems', action: :new_from_stockitems, controller: 'articles', as: 'user_new_article_from_stockitems'
  
  devise_scope :user do
    get "user/guidepost", action: :edit_guidepost, controller: 'users/registrations', as: 'edit_user_guidepost'
    put "user/guidepost", action: :update_guidepost, controller: 'users/registrations'
    post "user/guidepost", action: :update_guidepost, controller: 'users/registrations'

    get "users/basic", action: :edit_basic, controller: 'users/registrations', as: 'edit_user_basic'
    put "users/basic", action: :update_basic, controller: 'users/registrations'
    
    #get "users/locations", action: :edit_locations, controller: 'users/registrations', as: 'edit_user_locations'
    #get "users/articles", action: :edit_articles, controller: 'users/registrations', as: 'edit_user_articles'
    #put "users/articles", action: :update_articles, controller: 'users/registrations', as: 'user_articles'
    #put "users/locations", action: :update_locations, controller: 'users/registrations', as: 'user_locations'
    
    get "users/show/:id", action: :show, controller: 'users/registrations', as: 'user'
  end

  get "/pages/:page" => "pages#show"
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
