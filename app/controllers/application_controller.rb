class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(params[:user_id]), :alert => exception.message
  end

  private

  def current_user  # you don't really call this ever, except implicity in the authorize! method
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  #we have a session id when someone logs in correctly.
  end
end
