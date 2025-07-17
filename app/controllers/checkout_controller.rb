class CheckoutController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    # Affiche le formulaire
  end

  def create
    if request.format.json?
      data = JSON.parse(request.body.read)

      first_name = data["first_name"]
      last_name  = data["last_name"]
      email      = data["email"]
      phone      = data["phone"]
      address_number = data["address_number"]
      address_street = data["address_street"]
      postal_code    = data["postal_code"]
      city           = data["city"]
      cart       = data["cart_data"] || []

      raise "Panier vide ou invalide" if cart.empty?

      line_items = cart.map do |item|
        {
          price_data: {
            currency: "eur",
            product_data: { name: item["name"] },
            unit_amount: (item["price"].to_f * 100).to_i
          },
          quantity: item["qty"].to_i
        }
      end

      session = Stripe::Checkout::Session.create(
        payment_method_types: ["card"],
        customer_email: email,
        line_items: line_items,
        mode: "payment",
        success_url: checkout_success_checkout_index_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: root_url + "?cancel=true",
        metadata: {
          first_name: first_name,
          last_name: last_name,
          phone: phone,
          address_number: address_number,
          address_street: address_street,
          postal_code: postal_code,
          city: city,
          cart: cart.to_json
        }
      )

      render json: { url: session.url }
    else
      render json: { error: "Requête invalide" }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "🔥 Erreur Stripe : #{e.message}"
    render json: { error: e.message }, status: :internal_server_error
  end

  def success
    session_id = params[:session_id]
    return render plain: "Session ID manquant", status: :bad_request unless session_id

    session = Stripe::Checkout::Session.retrieve(session_id)
    metadata = session.metadata

    first_name = metadata["first_name"]
    last_name  = metadata["last_name"]
    phone      = metadata["phone"]
    address_number = metadata["address_number"]
    address_street = metadata["address_street"]
    postal_code = metadata["postal_code"]
    city = metadata["city"]
    cart       = JSON.parse(metadata["cart"]) rescue []
    email      = session.customer_email

    # Exemple d'envoi mail avec toutes les infos y compris l'adresse
    begin
      OrderMailer.new_order(
        email: email,
        cart: cart,
        first_name: first_name,
        last_name: last_name,
        phone: phone,
        address_number: address_number,
        address_street: address_street,
        postal_code: postal_code,
        city: city
      ).deliver_now
    rescue => e
      Rails.logger.error "📪 Erreur d'envoi de l'e-mail : #{e.message}"
    end

    # Affiche une page succès simple (à personnaliser)
    render :success
  end
end
