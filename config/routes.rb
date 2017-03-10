Rails.application.routes.draw do
  get 'order/new', to: 'order#new', as: :new_order

  resources :order
  get 'galeria/index'

  post '/pedidos', to: 'pedidos#create', as: :pedidos_create
  get '/pedidos', to: 'pedidos#index', as: :pedidos
  get 'pedidos/:id', to: 'pedidos#show', as: :pedido
  delete 'pedidos/:id/destroy', to: 'pedidos#destroy', as: :pedido_destroy
  delete 'pedidos/destroy_all', to: 'pedidos#destroy_all', as: :pedido_destroy_all
  post '/pedidos/:id/ped_comments', to: 'ped_comments#create', as: :pedido_ped_comments
  delete'/pedidos/:id/ped_comments/:ped_id', to: 'ped_comments#destroy', as: :pedido_ped_comment

  get '/tutorial', to: 'learn#index', as: :learn
  get '/tutorial/acabamento', to: 'learn#acabamento', as: :learn_acabamento
  get '/tutorial/modelagem', to: 'learn#modelagem', as: :learn_modelagem
  get '/tutorial/material', to: 'learn#material', as: :learn_material
  get '/tutorial/primeira_impressao', to: 'learn#primeira', as: :learn_primeira

  post '/checkouts', to: 'ckeckout#checkouts', as: :checkouts_show
  post '/order/notification', to: 'order#notification', as: :notification_order
  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

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

  post '/carrinho/create', to: 'carrinho#create', as: :create_carrinho
  post '/carrinho/:carrinho_id/car_comments', to: 'car_comments#create', as: :carrinho_car_comments
  delete '/carrinho/:carrinho_id/car_comments/:id', to: 'car_comments#destroy', as: :carrinho_car_comment
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
  get '/importar', to: 'posts#importar', as: :importar
  post '/importar/create', to: 'posts#importar_create', as: :importar_create

  get '/:user_name', to: 'profiles#show', as: :profile
  get '/:user_name/conta_bancaria', to: 'profiles#banco', as: :banco
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
  get ':user_name/printers', to: 'profiles#printers', as: :printers_profile
  get ':user_name/destaques', to:'profiles#destaques', as: :destaques_profile
  get ':user_name/projetos', to:'profiles#projetos', as: :projetos_profile
  get ':user_name/carrinho', to:'order#new', as: :carrinho
  post ':user_name/order/create', to:'order#create', as: :order_create
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
  #post 'pedidos/create', to: 'pedidos#create', as: :pedidos
  post 'posts/:id/checkout', to: 'ckeckout#create', as: :checkout
  get 'posts/:id/new', to: 'ckeckout#new', as: :new_checkout
end
