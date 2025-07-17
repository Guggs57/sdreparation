class OrderMailer < ApplicationMailer
  default to: "n_guggenbuhl@hotmail.com"

  def new_order(email:, cart:, first_name:, last_name:, phone: nil, address_number: nil, address_street: nil, postal_code: nil, city: nil)
    @cart = cart
    @first_name = first_name
    @last_name = last_name
    @customer_email = email
    @phone = phone
    @address_number = address_number
    @address_street = address_street
    @postal_code = postal_code
    @city = city

    mail(
      subject: "🛒 Nouvelle commande reçue",
      from: email
    )
  end
end
