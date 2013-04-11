class Admin::StoresController < ApplicationController
  layout "application"

  def index
    if current_user && current_user.role == "platform_admin"
      @stores = Store.all
    else
      redirect_to "/"
    end
  end


end
