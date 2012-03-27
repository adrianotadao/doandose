Doandose::Application.routes.draw do
  root :to => "pages#index"
  
  resources :people
  resources :page  
  resources :notifications
  resources :users do 
    get '/cadastro/' => 'identities#new', :as => :new_user
    post '/cadastro/' => 'identities#create', :as => :new_user
  end

end
