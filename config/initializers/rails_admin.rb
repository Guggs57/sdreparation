RailsAdmin.config do |config|
  # Use Sprockets for assets (pas Importmap)
  config.asset_source = :sprockets

  ## == Authentification Devise (admin uniquement) ==
  config.authenticate_with do
    warden.authenticate! scope: :admin_user
  end
  config.current_user_method(&:current_admin_user)

  ## == Actions disponibles dans l’interface admin ==
  config.actions do
    dashboard       # obligatoire
    index           # obligatoire
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  ## == Configuration spécifique du modèle Produit ==
  config.model 'Produit' do
    edit do
      field :name
      field :description
      field :image, :active_storage
    end

    list do
      field :image do
        pretty_value do
          if bindings[:object].image.attached?
            bindings[:view].tag.img(
              src: Rails.application.routes.url_helpers.rails_blob_path(bindings[:object].image, only_path: true),
              width: "100"
            )
          else
            "Pas d’image"
          end
        end
      end
      field :name
      field :description
    end
  end
end
