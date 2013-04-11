class Admin::StoresController < ApplicationController
  layout "application"

  def index
    if current_user && current_user.role == "platform_admin"
      @stores = Store.all
    else
      redirect_to "/"
    end
  end

  def change_status
    @store = Store.find(params[:id])
    @store.status = params[:status]
    @store.save
    if params[:status] == "live"
      flash[:notice] = "The store is now live."
      UserMailer.site_live(@store).deliver
    elsif params[:status] == "declined"
      flash[:notice] = "The store has been declined."
      UserMailer.site_declined(@store).deliver
    end
      
    redirect_to '/admin/stores'
  end

end
