class SessionsController < ApplicationController
  def new
  end
  
  def create
    @current_user = User.find_by(email: params[:email])
    if @current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      if session[:return_to]
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
        redirect_to blogs_path
      end
    end
  end

    
  def destroy
    session[:user_id] = @current_user = nil
  end

  def show
  end 
end
