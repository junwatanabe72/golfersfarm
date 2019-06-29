Rails.application.routes.draw do
  
 get "login", to: "sessions#new"
 post "login", to: "sessions#create"
 delete "logout", to: "sessions#destroy"
 
 root to: "toppages#index"
 resources :toppages,only:[:index , :about , :contact]
 
 get 'signup', to: 'users#new'
 resources :users
 
 resources :messages, only:[:create , :destroy]
  
end
