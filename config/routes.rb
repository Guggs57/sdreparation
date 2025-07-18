Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # ✅ Authentification avec Devise pour AdminUser
  devise_for :admin_users

  # ✅ Vitrine publique
  resources :products, only: [:index, :show]
  resources :carts, only: [:show]

  # ✅ Espace admin (géré par RailsAdmin si installé)
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

  # ✅ Page d’accueil
  root "home#index"

  get "/Admin", to: redirect("/admin")
end
