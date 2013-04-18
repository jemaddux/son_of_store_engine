class Admin::OrdersController < Admin::AdminController
  before_filter: :require_admin

  def index
    @orders = Order.all

    render :index
  end

  def show
    @order = Order.find(params[:id])

    render :show
  end

  def change_status
    order = Order.find(params[:id])
    order.status = params[:status]
    order.save
    redirect_to "/admin"
  end

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

