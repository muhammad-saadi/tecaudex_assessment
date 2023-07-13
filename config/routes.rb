Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:new, :create]
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

   resources :products, only: [:index, :new, :create, :show] do
     post 'add_to_cart', on: :member
   end

   # root to: 'pages#landing'

    get 'vendor_products', to: 'products#vendor_products'
end
