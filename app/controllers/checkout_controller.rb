class CheckoutController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    # Affiche le formulaire de checkout
  end

  def create
    puts "📥 Données reçues : #{params.inspect}"

    cart = JSON.parse(params[:cart_data]) rescue []
    raise "Panier vide ou invalide" if cart.empty?

    line_items = cart.map do |item|
      {
        price_data: {
          currency: "eur",
          product_data: {
            name: item["name"]
          },
          unit_amount: (item["price"].to_f * 100).to_i
        },
        quantity: item["qty"].to_i
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: line_items,
      mode: "payment",
      success_url: root_url + "?success=true",
      cancel_url: root_url + "?cancel=true"
    )

    redirect_to session.url, allow_other_host: true
  rescue => e
    Rails.logger.error "🔥 Erreur Stripe : #{e.message}"
    flash[:alert] = "Une erreur est survenue lors de la création du paiement : #{e.message}"
    redirect_to checkout_new_path
  end
end
