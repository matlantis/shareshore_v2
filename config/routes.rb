Rails.application.routes.draw do

  root "pages#index"

  resources :messages, only: [:create]
  resources :user_article_requests, only: [:create]
  resources :houses, only: [:show]

  get '/search', to: 'searches#new', as: 'search'

  get '/contact', to: 'contacts#new', as: "contact"
  resources :contacts, only: [:new, :create]

  post '/userreply', to: 'messages#userreply'

  # use own devise controllers
  devise_for :users, controllers: {
               confirmations: "users/confirmations",
               #omniauth_callbacks: "users/omniauth_callbacks",
               passwords: "users/passwords",
               registrations: "users/registrations",
               sessions: "users/sessions",
               unlocks: "users/unlocks"
             }

  resources :articles, only: [ :show, :index, :update] do
    collection do
      post 'create_from_index'
      post 'create_from_stockitems'
    end
  end

  get '/user/new_article_from_stockitems', action: :new_from_stockitems, controller: 'articles', as: 'user_new_article_from_stockitems'

  devise_scope :user do
    get "users/:id", action: :show, controller: 'users/registrations', as: 'user'
  end

  get "/pages/index", to: "pages#index"
  get "/pages/:page", to: "pages#show"
  get "/pages/guideline", as: "guideline" # needed for link to guidelines in email

  get "accept_cookies", to: "application#accept_cookies"
end
