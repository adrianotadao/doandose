Doandose::Application.routes.draw do
  root :to => "pages#index"
  match "/auth/:provider/callback" => "sessions#create"
  
  resources :people
  resources :page  
  resources :notifications

  namespace :users, :path => 'usuario' do 
    match '/sair' => 'sessions#destroy', :as => :destroy_session

    get  '/cadastro/' => 'identities#new', :as => :new_user
    match "/auth/:provider/callback" => "sessions#create"
  end

  namespace :admin do
    resource :partners, :path => 'parceiros'
  end

end
