class OrderMailer < ApplicationMailer
  default to: "ton-client@exemple.com"  # Remplace par l'adresse réelle

  def new_order_email
    @order = params[:order]
    mail(
      from: @order.email,
      subject: "Nouvelle commande de #{@order.name}"
    )
  end
end
