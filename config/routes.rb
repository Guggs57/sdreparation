Rails.application.routes.draw do
  # ✅ Session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    resources :products
  end

  resources :orders, only: [:new, :create] do
  collection do
    get :success
  end
end
  # ✅ Vitrine publique (utilisateurs)
  resources :products, only: [:index, :show]

  # ✅ Page d’accueil publique
  root "home#index"
end

