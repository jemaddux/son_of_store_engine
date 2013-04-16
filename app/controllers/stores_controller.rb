class StoresController < ApplicationController
  layout "application"

  def show

    @user ||= current_user

    @admin ||= @user && (@user.role?(:admin) || @user.role?(:platform_admin))

    @store ||= Store.includes(:categories).find_by_path(params[:store_id])

    @user_cart ||= Cart.find_current_cart(session[:user_session_id], @store)

    if @store && @store.status != "live"
      render :text => '404 - Store Not Found', :status => '404'
      return
    end

    @categories ||= @store.categories
    @products ||= Product.where(store_id: @store.id).shuffle[0..2]
    render layout: "store"
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

  private

  # def find_store_id
  #   store_id = 0
  #   if current_user.role == "platform_admin"
  #     store_id = Store.find_by_path(params[:store_id])
  #   elsif current_user.role == "stocker" || current_user.role == "admin"
  #     store_id = current_user.store_id
  #   end
  #   store_id
  # end

end
