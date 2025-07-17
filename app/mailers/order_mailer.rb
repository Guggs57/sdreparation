class OrderMailer < ApplicationMailer
  default to: "n_guggenbuhl@hotmail.com"

  def new_order(email:, cart:, first_name:, last_name:)
    @cart = cart
    @first_name = first_name
    @last_name = last_name
    @customer_email = email

    mail(
      subject: "🛒 Nouvelle commande reçue",
      from: email
    )
  end
end
