Doandose::Application.routes.draw do
  root :to => "pages#index"
  match "/auth/:provider/callback" => "users/sessions#create"
  match '/auth/failure' => 'users/sessions#failure'
  
  resources :people
  resources :page  
  resources :notifications

  namespace :users, :path => 'usuario' do 
    match '/login' => 'sessions#new', :as => :new_session
    match '/sair' => 'sessions#destroy', :as => :destroy_session

    get  '/cadastro/' => 'identities#new', :as => :new_user
    post '/cadastro/' => 'identities#create', :as => :new_user
    get  '/meu-cadastro/' => 'identities#edit', :as => :edit_user
    put  '/meu-cadastro/' => 'identities#update', :as => :edit_user

    get '/esqueci-minha-senha/' => 'users/passwords#new', :as => :new_password
    post '/esqueci-minha-senha/' => 'users/passwords#create', :as => :new_password
    get '/esqueci-minha-senha/:token' => 'passwords#edit', :as => :edit_password
    put '/esqueci-minha-senha/:token' => 'passwords#update', :as => :edit_password
  end

  namespace :admin do
    resource :partners, :path => 'parceiros'
  end
  
  namespace :mobile do
    root :to => 'pages#index'
    resources :partners, :path => 'parceiros'
    
    get '/cadastro/' => 'people#new', :as => :signup
  end

end