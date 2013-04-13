class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      if params[:redirect]
        redirect_to params[:redirect]
      elsif user.role? :user
        redirect_back_or_to root_url, notice: "Logged in."
      elsif user.role?(:stocker)
        redirect_to "/"
      elsif user.role?(:platform_admin)
        redirect_to "/admin/stores/"
      elsif user.role?(:admin) || user.role?(:superuser)
        redirect_to '/admin', notice: "Logged in."
      end
    else
      flash.now.alert = "Email or password was invalid."
      render :new
    end
  end

  def new
    @redirect = params[:redirect]
  end

  def destroy
    logout
    redirect_to root_url, notice: "Logged out."
  end
end
