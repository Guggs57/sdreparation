Rails.application.routes.draw do
  # ✅ Back-office RailsAdmin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # ✅ Authentification Devise pour AdminUser via une URL secrète
  devise_for :admin_users, path: 'goku-ssj4-secret'

  # ✅ Vitrine publique
  resources :products, only: [:index, :show]
  get '/cart', to: 'carts#show', as: 'cart'
  post '/cart/add/:id', to: 'carts#add', as: 'cart_add'

  # ✅ Espace admin privé (utilisé uniquement après login)
  namespace :admin do
    resources :products
  end

  # ✅ Checkout (formulaire client + paiement)
  resources :checkout, only: [:new, :create] do
    collection do
      get 'success', to: 'checkout#success', as: 'checkout_success'
    end
  end

  # ✅ Commandes (peut être gardé pour historique ou confirmation)
  resources :orders, only: [:new, :create] do
    collection do
      get :success
    end
  end

  # ✅ Page d’accueil
  root "home#index"

  # ✅ Redirection propre pour éviter /Admin mal tapé
  get "/Admin", to: redirect("/admin")
end
