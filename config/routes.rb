Rails.application.routes.draw do
  root to: "toppages#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get 'about', to: "toppages#about"
  
  get 'signup', to: 'users#new'
  
  resources :toppages,only:[:index]
  
  resources :users do
    member do
      get :status
    end
  end
 
  resources :messages, only:[:create , :destroy]
  resources :contacts, only: [:new, :create]
end
