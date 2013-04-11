class OrdersController < ApplicationController
  def index
    @orders = Order.all
    authorize! :manage, Order

    render :index
  end

  def display
    @order = Order.find_by_confirmation_hash(params[:confirmation_hash])
  end

  def show
    @order = Order.find(params[:id])
    authorize! :manage, Order

    render :show
  end

  def change_status
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to "/admin"
  end

  def new
    if current_cart.calculate_total_cost <= 50
      flash[:error] =
        "Sorry Partner. Your cart must contain at least $0.51 worth of goods."
      redirect_to root_path and return
    end
    @order = Order.new
    authorize! :create, Order

    render :new
  end

  def edit
    @order = Order.find(params[:id])
    authorize! :update, Order
  end


  def create

    user_id = ( current_user.id if current_user ) || nil 
    user_email = (current_user.email if current_user ) || params[:user_email]

    shipping_id = Order.shipping_address(params, current_user).id
    billing_id  = Order.billing_address(params, current_user).id

    @order = Order.create_from_cart_for_user(current_cart,
                                                user_id,
                                                params[:card_number],
                                                shipping_id,
                                                billing_id)
    if @order.valid? 

      UserMailer.order_confirmation(user_email, @order).deliver
      current_cart.destroy
      session[:cart_id] = nil
      redirect_to display_path(@order.confirmation_hash), notice: 'Thanks! Your order was submitted.'
    else

      @order = Order.new
      authorize! :create, Order

      render action: "new"
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url
  end
end
