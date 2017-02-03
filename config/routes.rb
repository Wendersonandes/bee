Rails.application.routes.draw do
  get 'order/new'

  post 'order/create'

  get 'order/index'

  get 'galeria/index'
  post '/checkouts', to: 'ckeckout#checkouts', as: :checkouts_show
  post ':id/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':id/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  get 'printers', to: 'printers#index', as: :printers
  get 'printers/new', to: 'printers#new', as: :new_printer
  get 'printers/:id/active', to: 'printers#active', as: :active_printer
  get 'printers/:id/deactive', to: 'printers#deactive', as: :deactive_printer
  resources :printers

  get 'galeria', to: 'galeria#index', as: :galeria
  get 'galeria/engenharia', to: 'galeria#engenharia', as: :galeria_engenharia
  get 'galeria/decoracao', to: 'galeria#decoracao', as: :galeria_decoracao
  get 'galeria/moda', to: 'galeria#moda', as: :galeria_moda
  get 'galeria/outros', to: 'galeria#outros', as: :galeria_outros
  get 'galeria/projetos', to: 'galeria#todos', as: :galeria_todos


  get 'browse', to: 'posts#browse', as: :browse_posts

  get 'home/index'

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'

  get 'posts', to: 'posts#index', as: :posts
  get "/users/auth/facebook" => "callbacks#facebook", as: :facebook
  get 'profiles/show'
  resources :posts do
    collection do
      get :autocomplete
      get :autocomplete2
      get :autocompletepre
      get :autocompletepre2
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "callbacks" }
  root 'home#index'
  get '/search', to: 'home#search', as: :search

  get ':id', to: 'profiles#show', as: :profile
  get ':id/edit', to: 'profiles#edit', as: :edit_profile
  patch ':id/edit', to: 'profiles#update', as: :update_profile
  get ':id/printers', to: 'profiles#printers', as: :printers_profile
  get ':id/destaques', to:'profiles#destaques', as: :destaques_profile
  get ':id/projetos', to:'profiles#projetos', as: :projetos_profile

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
  post 'posts/:id/checkout', to: 'ckeckout#create', as: :checkout
  get 'posts/:id/new', to: 'ckeckout#new', as: :new_checkout
end
