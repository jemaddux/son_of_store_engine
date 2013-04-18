class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end

  helper_method :current_cart

  def current_session
    Session.find(session[:user_session_id])
  rescue
    user_session = Session.create
    session[:user_session_id] = user_session.id
    user_session
  end
end
