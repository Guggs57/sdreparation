class CheckoutController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new
  end

  def create
    if request.format.json?
      data = JSON.parse(request.body.read)

      first_name = data["first_name"]
      last_name  = data["last_name"]
      email      = data["email"]
      phone      = data["phone"]
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
        success_url: checkout_success_checkout_index_url,
        cancel_url: root_url + "?cancel=true"
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
    # Vue app/views/checkout/success.html.erb
  end
end
