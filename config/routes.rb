Doandose::Application.routes.draw do
  mount Resque::Server.new, at: "/resque"

  root to: "application#after_sing_in"

  match "/auth/:provider/callback" => "users/sessions#create"
  match '/auth/failure/' => 'users/sessions#failure'
  post '/send_email/' => 'send_mail#create', as: :send_mail
  post '/cadastro/email-em-uso/' => 'people#email_in_use'

  get '/quem_somos/' => 'pages#about_us', as: :about_us
  get '/depoimentos/' => 'testimonials#index', as: :testimonials

  namespace :users, :path => 'usuario' do
    match '/login' => 'sessions#new', as: :new_session
    match '/sair' => 'sessions#destroy', as: :destroy_session

    get  '/cadastro/' => 'identities#new', as: :new_user
    post '/cadastro/' => 'identities#create', as: :new_user
    get  '/meu-cadastro/' => 'identities#edit', as: :edit_user
    put  '/meu-cadastro/' => 'identities#update', as: :edit_user

    get '/esqueci-minha-senha/' => 'passwords#new', as: :new_password
    post '/esqueci-minha-senha/' => 'passwords#create', as: :new_password
    get '/esqueci-minha-senha/:token' => 'passwords#edit', as: :edit_password
    put '/esqueci-minha-senha/:token' => 'passwords#update'
  end

  post '/find_elements_to_map/' => 'gmap#find_elements_to_map'
  post '/find_elements_to_notification/' => 'gmap#find_elements_to_notification'

  resources :people do
    get ':id/page/:page', action: :show, on: :collection
  end

  resources :pages, only: [:index, :show]

  resources :notifications, only: [:index, :show] do
    get 'page/:page', action: :index, on: :collection
    get :list_user
    get :print
    member do
      get :indication_friend
      post :send_indication
      get :confirm
      get :undo_confirm
      post :confirmed
    end
  end

  resources :campaigns, only: [:index, :show] do
    get 'page/:page', action: :index, on: :collection
    get :print
    member do
      get :undo_confirm
      post :confirmed
    end
  end

  resources :person_notification, only: :index do
    member do
      get :canceling
    end
  end
  resources :companies, only: [:index, :show]
  resources :informations, only: [:show]

  get '/dicas/' => 'tips#index', as: :tips

  namespace :admin do
    root :to => 'companies#index'
    match '/sair/' => 'base#destroy', as: :destroy_session
    post '/estatistica/cadastro-por-dia/' => 'statistics#subscribe_per_date'
    resources :pages, only: :index
    resources :companies
    resources :bloods
    resources :notifications
    resources :people
    resources :informations
    resources :campaigns
    get '/estatisticas/' => 'statistics#index', as: :statistics
  end

  namespace :institution, path: 'instituicao' do
    root :to => 'notifications#index'
    get '/sair/' => 'base#destroy', as: :destroy_company_session
    resources :notifications
    resources :campaigns, except: :destroy
    resources :person_notifications, only: :show do
      member do
        post :participation
        post :send_sms
        post :send_email
      end
    end
  end



end