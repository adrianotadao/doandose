Doandose::Application.routes.draw do
  root :to => "pages#index"

  match "/auth/:provider/callback" => "users/sessions#create"
  match '/auth/failure' => 'users/sessions#failure'
  post '/send_email/' => 'send_mail#create', :as => :send_mail

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

  post '/find_elements_to_map/' => 'gmap#find_elements_to_map'
  post '/find_elements_to_notification/' => 'gmap#find_elements_to_notification'

  resources :people do
    get ':id/page/:page', :action => :show, :on => :collection
  end
  resources :page, only: [:index, :show]

  resources :notifications, only: [:index, :show] do
    get 'page/:page', :action => :index, :on => :collection
    get :list_user
    get :complete
    get :print
    member do
      get :indication_friend
      post :send_indication
      get :confirm
      get :undo_confirm
      post :confirmed
    end
  end

  resources :person_notification, only: :index do
    member do
      get :canceling
    end
  end
  resources :partners, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resources :informations, only: [:show]
  resources :campaigns, only: [:index, :show]
  get '/dicas/' => 'tips#index', as: :tips

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
    match '/sair' => 'base#destroy', :as => :destroy_company_session
    resources :pages, :only => :index
    resources :notifications
  end
end