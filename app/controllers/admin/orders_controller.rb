class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.all
    authorize! :manage, Order

    render :index
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

  # def edit
  #   @order = Order.find(params[:id])
  #   authorize! :update, Order
  # end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      redirect_to orders_url
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url
  end
end

