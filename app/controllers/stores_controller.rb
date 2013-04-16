class StoresController < ApplicationController
  layout "application"

  def show

    @user = current_user

    @admin = @user && (@user.role?(:admin) || @user.role?(:platform_admin))

    @store = Store.includes(:categories, :products).find_by_path(params[:store_id])

    @user_cart = Cart.find_current_cart(session[:user_session_id], @store)

    if @store && @store.status != "live"
      render :text => 'This store is closed for maintenance. Please check back soon.', :status => '404'
      return
    end

    @categories ||= @store.categories
    @products ||= @store.products.shuffle[0..2]
    render layout: "store"
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def pending
    @store ||= Store.find_by_path(params[:path])
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
end
