Rails.application.routes.draw do

  resources :houses, only: [:show, :index, :edit, :update]

  resources :stockitems
  post 'stockitems/new', to: "stockitems#new"
  
  get '/searches', to: 'searches#new'
  resources :searches, only: [:new, :create]

  get '/contacts', to: 'contacts#new'
  resources :contacts, only: [:new, :create]
  
  # use own devise controllers
  devise_for :users, controllers: {
               confirmations: "users/confirmations",
               #omniauth_callbacks: "users/omniauth_callbacks",
               passwords: "users/passwords",
               registrations: "users/registrations",
               sessions: "users/sessions",
               unlocks: "users/unlocks"
             }
  
  root "pages#index"

  resources :articles
  resources :locations, except: [ :new]

  get '/users/:user_id/articles', action: :index_user, controller: 'articles', as: 'articles_user'
  get '/locations/:location_id/articles', action: :index_location, controller: 'articles', as: 'articles_location'
  get '/users/:user_id/locations', action: :index_user, controller: 'locations', as: 'locations_user'

  get '/user/locations', action: :index_owner, controller: 'locations', as: 'user_locations'
  get '/user/articles', action: :index_owner, controller: 'articles', as: 'user_articles'
  get '/user/new_article_from_stockitems', action: :new_from_stockitems, controller: 'articles', as: 'user_new_article_from_stockitems'
  
  devise_scope :user do
    get "users/guidepost", action: :guidepost, controller: 'users/registrations', as: 'user_guidepost'
    put "users/guidepost", action: :update_guidepost, controller: 'users/registrations'
    post "users/guidepost", action: :update_guidepost, controller: 'users/registrations'

    get "users/show/:id", action: :show, controller: 'users/registrations', as: 'user'
    get "users", to: 'users/registrations#index', as: 'users'
  end

  get "/pages/index", to: "pages#index"
  get "/pages/admin", to: "pages#admin"
  get "/pages/:page", to: "pages#show"
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
