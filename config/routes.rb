Rails.application.routes.draw do
  
 mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
 
  get 'relationships/create'
  get 'relationships/destroy'
  root to: "toppages#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get 'about', to: "toppages#about"
  get 'privacy', to: "toppages#privacy"
  get 'protocol', to: "toppages#protocol"
  
  get 'signup', to: 'users#new'
  
  resources :toppages,only:[:index]
  
  resources :users do
    member do
      get :message
      get :swing
      get :gear
      get :history 
      get :tnew
      get :followings
      get :followers
    end
  end
 
  resources :tournaments,only:[:create,:destroy]
  resources :messages, only:[:create , :destroy]
  resources :contacts, only: [:new, :create]
  
  resources :relationships, only: [:create, :destroy]
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
end
