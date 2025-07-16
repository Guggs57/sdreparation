Rails.application.routes.draw do
  get "home/index"
  # ✅ Session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    resources :products
  end

  # ✅ Vitrine publique (utilisateurs)
  resources :products, only: [:index, :show]

  # ✅ Page d’accueil publique
  root "home#index"
end