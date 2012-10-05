Doandose::Application.routes.draw do

  root :to => "pages#index"

  resources :people
  resources :page, only: [:index, :show]

  resources :notifications, only: :index do
    member do
      get :confirm
      post :confirmed
    end
  end

  resource :person_notification, only: :index
  resources :partners, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resources :informations, only: [:show]
  resources :campaigns, only: [:index, :show]



  namespace :users, :path => 'usuario' do
    match '/sair/' => 'sessions#destroy', as: :destroy_session
    match '/auth/failure/' => 'sessions#failure'
    match '/auth/:provider/callback/' => 'sessions#create'

    get  '/login/' => 'sessions#new', as: :sign_in
    post '/login/' => 'sessions#create', as: :sign_in

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
    root :to => 'companies#index'
    match '/sair/' => 'base#destroy', :as => :destroy_session
    resources :pages, :only => :index
    resources :partners
    resources :companies
    resources :bloods
    resources :notifications
    resources :people
    resources :informations
    resources :campaigns
  end

  namespace :institution, :path => 'instituicao' do
    root :to => 'pages#index'
    resources :pages, :only => :index
  end
end