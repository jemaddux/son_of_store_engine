class CartsController < ApplicationController
  def index
    @carts = current_session.carts
  end

  def show
    store = Store.find_by_path(params[:store_id])
    @cart = current_session.carts.find_by_store_id(store.id)
  end

  def new
    @cart = Cart.new
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart], session_id: current_session.id)

    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update_attributes(params[:cart])
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    redirect_to carts_path
  end

end
