class StoresController < ApplicationController
  layout "application"

  def show
    @store = Store.find_by_path(params[:store_id])
    if @store.status != "live"
      render :text => '404 - Store Not Found', :status => '404'
      return
    end
    @categories = Category.where(store_id: @store.id)
    @products = Product.where(store_id: @store.id).shuffle[0..2]
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def pending
    @store = Store.find_by_path(params[:path])
    render :pending
  end

  def create
    @store = Store.new(params[:store])
    @store.status = "pending"
    if @store.save
      redirect_to "/stores/pending/#{@store.path}", notice: 'Store was successfully created.'
    else
      render action: "new"
    end    
  end

  def change_status
    @store = Store.find(params[:id])
    @store.status = params[:status]
    @store.save
    if params[:status] == "live"
      flash[:notice] = "The store is now live."
      #email site is live #UserMailer.order_confirmation(user_email, @order).deliver
    elsif params[:status] == "declined"
      flash[:notice] = "The store has been declined."
      #email site is declined #UserMailer.order_confirmation(user_email, @order).deliver
    end
      
    redirect_to '/admin/stores'
  end

  def update
    @store = Store.find_by_path(params[:id])
    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to stores_url
  end

end
