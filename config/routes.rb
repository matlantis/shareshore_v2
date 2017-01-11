Rails.application.routes.draw do

  resources :user_article_requests
  resources :houses, only: [:show, :index, :edit, :update]

  resources :stockitems
  post 'stockitems/new', to: "stockitems#new"
  
  get '/search', to: 'searches#new', as: 'search'
  #resources :searches, only: [:new, :create]

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
  get "/pages/guideline", as: "guideline"
  
  get "accept_beta", to: "application#accept_beta"
end
