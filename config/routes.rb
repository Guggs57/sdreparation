Rails.application.routes.draw do
  get "checkout/create"
  get "carts/show"
  # ✅ Session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    resources :products
  end

  post "/checkout", to: "checkout#create"
resources :carts, only: [:show]

  resources :orders, only: [:new, :create] do
  collection do
    get :success
  end
end

    resources :checkout, only: [:new, :create]


  # ✅ Vitrine publique (utilisateurs)
  resources :products, only: [:index, :show]

  resources :carts, only: [:show]

  # ✅ Page d’accueil publique
  root "home#index"
end

