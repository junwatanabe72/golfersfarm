Rails.application.routes.draw do
  
  root to: "toppages#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get 'about', to: "toppages#about"
  get 'privacy', to: "toppages#privacy"
  
  
  get 'signup', to: 'users#new'
  
  resources :toppages,only:[:index]
  
  resources :users do
    member do
      get :message
      get :swing
      get :gear
      get :history 
      get :tnew
    end
  end
 
  resources :tournaments,only:[:create,:destroy]
  resources :messages, only:[:create , :destroy]
  resources :contacts, only: [:new, :create]
  
  resources :account_activations, only: [:edit]
  
  
end
