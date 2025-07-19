class CartsController < ApplicationController
  def show
    @cart = session[:cart] || []
    @products = Product.find(@cart)
  end

  def add
    session[:cart] ||= []
    product_id = params[:id].to_i

    unless session[:cart].include?(product_id)
      session[:cart] << product_id
      flash[:notice] = "Produit ajouté au panier."
    else
      flash[:alert] = "Ce produit est déjà dans le panier."
    end

    redirect_to cart_path
  end
end
