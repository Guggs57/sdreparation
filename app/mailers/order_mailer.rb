class OrderMailer < ApplicationMailer
  default to: "n_guggenbuhl@hotmail.com" # remplace ici par l'email réel du client

  def new_order_email
    @order = params[:order]
    mail(
      from: @order.email,
      subject: "Nouvelle commande de #{@order.name}"
    )
  end
end
