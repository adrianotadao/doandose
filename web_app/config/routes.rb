Doandose::Application.routes.draw do
  root :to => "pages#index"
  
  resources :users
  resources :people
  resources :page  
  resources :notifications
  
end
