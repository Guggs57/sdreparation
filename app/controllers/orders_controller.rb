class OrdersController < ApplicationController
  def new
    # Affiche le formulaire
  end

  def create
    @order = Order.new(
      name: params[:order][:name],
      email: params[:order][:email],
      phone: params[:order][:phone],
      address: params[:order][:address],
      items: params[:cart_json]
    )

    if @order.save
      # Envoi du mail
      OrderMailer.with(order: @order).new_order_email.deliver_now
      redirect_to success_orders_path
    else
      flash.now[:alert] = "Une erreur est survenue lors de la commande."
      render :new
    end
  end

  def success
    # Affiche un message de confirmation
  end
end
