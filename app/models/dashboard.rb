class Dashboard
  attr_reader :store_id

  def initialize(store_id)
    @store_id = store_id
  end

  def products
    @products ||= Product.where(store_id: store_id)
  end

  def orders
    @orders ||= Order.where(store_id: store_id).all
  end

  def statuses
    %w[pending cancelled paid shipped returned]
  end

  def categories
    @categories ||= Category.where(store_id: store_id).by_name
  end

  def retired_products
    @retired_products ||= Product.where(store_id: store_id).retired
  end

  def admins
    admins ||= User.where(store_id: store_id)
    @admins = admins.reject{|a| a.role == "user" || a.role == "platform_admin"}
  end

  def orders_by_status
    orders_with_status = {}
    Order.all.each do |order|
      if orders_with_status[order.status] == nil
        orders_with_status[order.status] = [order]
      else
        orders_with_status[order.status] << order
      end
    end
    orders_with_status
  end
end
