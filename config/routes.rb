Rails.application.routes.draw do
  
 get 'contact', to: "contacts#new"
 post 'contact', to: "contacts#create"

 get "login", to: "sessions#new"
 post "login", to: "sessions#create"
 delete "logout", to: "sessions#destroy"
 
 root to: "toppages#index"
 get 'about', to: "toppages#about"
 resources :toppages,only:[:index]
 
 
 get 'signup', to: 'users#new'
 
 resources :users do
  member do
      get :status
  end
 end
 
 resources :messages, only:[:create , :destroy]
  
end
