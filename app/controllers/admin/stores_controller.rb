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
      flash[:notice] = "The store, #{@store.name}, is now live."
      Resque.enqueue(NotifySiteLive, @store.name, @store.id)
    elsif params[:status] == "declined"
      flash[:notice] = "I'm sorry but the store, #{@store.name}, store has been declined."
      Resque.enqueue(NotifySiteDeclined, @store.name, @store.id)
    elsif params[:status] == "disabled"
      flash[:notice] = "The store, #{@store.name}, has been disabled."
    end

    redirect_to '/admin/stores'
  end

end
