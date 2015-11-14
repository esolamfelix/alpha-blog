class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] #optimization to not hit the database mutiple time. If we already have @current_user just use it. if not go find it
  end

  def logged_in?
    !!current_user # !! turn anything into boolean. do we have a current user ?
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
