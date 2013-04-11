class OrdersController < ApplicationController


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

    unless params[:user_email] || current_user
      render action: "new", notice: "Please enter an email or log in."
      return
    end

    @order = Order.create_from_cart_for_user(current_cart,
                                                order_user.id,
                                                params[:card_number],
                                                shipping_id(params),
                                                billing_id(params))
    
    if @order.valid?
      send_order_confirmation(order_user.email, @order)
      destroy_shopping_cart!
      redirect_to display_path(@order.confirmation_hash), notice: 'Thanks! Your order was submitted.'
    else
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

  private 

  def order_user
    email = params[:user_email]
    current_user || User.find_by_email(email) || User.create_guest_user(email)
  end 

  def send_order_confirmation(email,order)
    UserMailer.order_confirmation(email, order).deliver
  end

  def destroy_shopping_cart!
    current_cart.destroy if current_cart
    session[:cart_id] = nil
  end

  def shipping_id(params)
    Order.shipping_address(params, current_user).id
  end

  def billing_id(params)
    Order.billing_address(params, current_user).id
  end
end
