class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:sesh][:username])
    if user && user.authenticate(params[:sesh][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in nucka."
      redirect_to user_path(user) #the argument of the user object   becomes the :id of the params in the usercontroller.
    else
      flash[:errors] = "You typed in the wrong username/password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "You successfully logged out"
    redirect_to "/login"
  end



end
