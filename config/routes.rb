Rails.application.routes.draw do
  # ✅ Gestion de la session admin (login/logout)
  resource :session, only: [:new, :create, :destroy]

  # ✅ Espace admin sécurisé
  namespace :admin do
    get "products/index"
    get "products/new"
    get "products/create"
    get "products/edit"
    get "products/update"
    get "products/destroy"
    resources :products
  end

  # ✅ Page publique d’accueil
  root "home#index"
end