Rails.application.routes.draw do
  get "carts/show"

  # ✅ Accès caché à la page de login admin
  get "/Admin", to: "sessions#new"

  # ✅ Session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    resources :products
  end

  # ✅ Checkout
  resources :checkout, only: [:new, :create] do
    collection do
      get 'success', to: 'checkout#success', as: 'checkout_success'
    end
  end

  # ✅ Commandes
  resources :orders, only: [:new, :create] do
    collection do
      get :success
    end
  end

  # ✅ Vitrine publique
  resources :products, only: [:index, :show]
  resources :carts, only: [:show]

  # ✅ Page d’accueil
  root "home#index"
end
