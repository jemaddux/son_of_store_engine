class StoresController < ApplicationController
  layout "application"
  caches_page :show

  def show
    @user = current_user
    @store = Store.includes(:categories, :products).find_by_path(params[:store_id])
    @user_cart = Cart.find_current_cart(session[:user_session_id], @store)

    if @store && @store.status != "live"
      render :text => 'This store is closed for maintenance. Please check back soon.', :status => '404'
      return
    end

    @categories ||= @store.categories
    @products ||= @store.products[0..2]
    render layout: "store"
    expires_in 5.minutes, public: true
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
      redirect_to "/stores/pending/#{@store.path}"
    else
      render action: "new"
    end
  end

  def update
    @store = Store.find_by_path(params[:store][:path])
    if @store.update_attributes(params[:store])
      redirect_to store_home_path(@store.path), notice: "The store #{@store.name} was successfully updated. Your store path is #{@store.path}, and your description is #{@store.description}."
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
