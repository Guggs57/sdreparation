class SessionsController < ApplicationController
  def new
  end

  def create
    user = AdminUser.find_by(email: params[:email])
      if user&.authenticate(params[:password])
      session[:admin_user_id] = user.id
      redirect_to root_path, notice: "Connexion réussie."
    else
      flash.now[:alert] = "Identifiants incorrects"
      render :new
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to root_path, notice: "Déconnecté avec succès." 
  end
end
