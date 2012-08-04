Doandose::Application.routes.draw do

  root :to => "pages#index"

  resources :people
  resources :page
  resources :notifications

  match "/auth/:provider/callback" => "users/sessions#create"
  match '/auth/failure' => 'users/sessions#failure'

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
    root :to => 'pages#index'
    get  '/sair/' => 'application#logout', :as => :destroy_session
    resources :pages, :only => :index
    resources :partners
    resources :companies
    resources :bloods, :only => [:index, :new, :create, :edit, :update, :destroy]
  end

  namespace :institution, :path => 'instituicao' do
    root :to => 'pages#index'
    resources :pages, :only => :index
  end
end