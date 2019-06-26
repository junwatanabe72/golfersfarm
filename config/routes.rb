Rails.application.routes.draw do
  get 'toppages/index'
  get 'toppages/about'
  get 'toppages/contact'
 root to: "toppages#index"

end
