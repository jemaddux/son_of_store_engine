class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      if params[:redirect]
        redirect_to params[:redirect]
      elsif user.role? :user
        redirect_to :back, notice: "Logged in."
      elsif user.role?(:platform_admin)
        redirect_to "/admin/stores/"
      elsif user.role?(:admin) || user.role?(:stocker)
        store = Store.find_by_id(user.store_id)
        redirect_to store_index_path(store), notice: "Logged in."
      elsif user.role?(:pending_admin)
        redirect_to '/signup_admin', notice: "Please update your password."
      end
    else
      render :new, notice: "Email or password was invalid."
    end
  end

  def new
    @redirect = params[:redirect]
  end

  def destroy
    logout
    redirect_to root_url, notice: "Logged out."
    session[:user_session_id] = nil
  end
end
