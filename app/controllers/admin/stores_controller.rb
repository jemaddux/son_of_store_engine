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
      flash[:notice] = "The store, #{@store.name}, is now live."
      Resque.enqueue(NotifySiteLive, @store)
    elsif params[:status] == "declined"
      flash[:notice] = "I'm sorry but the store, #{@store.name}, store has been declined."
      Resque.enqueue(NotifySiteDeclined, @store)
    elsif params[:status] == "disabled"
      flash[:notice] = "The store, #{store.name}, has been disabled."
    end

    redirect_to '/admin/stores'
  end

end
