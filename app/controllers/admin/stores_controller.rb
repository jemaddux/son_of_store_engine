class Admin::StoresController < ApplicationController
  layout "application"

  def index
    if current_user && current_user.role == "platform_admin"
      @active_stores = Store.where(status: "live")
      @inactive_stores = Store.all.reject{ |s| s.status == "live" }
    else
      redirect_to "/"
    end
  end

  def change_status
    @store = Store.find(params[:id])
    @store.status = params[:status]
    @store.save
    if params[:status] == "live"
      flash[:notice] = "#{@store.name} is now live."
      Resque.enqueue(NotifySiteLive, @store)
    elsif params[:status] == "declined"
      flash[:notice] = "#{@store.name} has been declined."
      Resque.enqueue(NotifySiteDeclined, @store)
    elsif params[:status] == "disabled"
      flash[:notice] = "#{@store.name} has been disabled."
    end
      
    redirect_to '/admin/stores'
  end

end
