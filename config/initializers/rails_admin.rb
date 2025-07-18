RailsAdmin.config do |config|
  config.asset_source = :importmap

  ## == Devise (sécurisation accès admin) ==
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
end
