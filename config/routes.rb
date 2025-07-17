Rails.application.routes.draw do
  get "carts/show"

  # ✅ Session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    resources :products
  end

  # ✅ Checkout avec route success CORRECTE
  resources :checkout, only: [:new, :create] do
    collection do
      get 'success', to: 'checkout#success', as: 'checkout_success'
    end
  end


  # ✅ Commandes avec page de succès
  resources :orders, only: [:new, :create] do
    collection do
      get :success
    end
  end

  # ✅ Vitrine publique (utilisateurs)
  resources :products, only: [:index, :show]
  resources :carts, only: [:show]

  # ✅ Page d’accueil publique
  root "home#index"
end
