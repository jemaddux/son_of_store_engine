class Dashboard
  attr_reader :store_id

  def initialize(store_id)
    @store_id = store_id
  end

  def store
    @store ||= Store.find_by_id(@store_id)
  end

  def products
    @products ||= store.products
  end

  def store_orders
    @orders ||= store.orders
  end

  def statuses
    %w[pending cancelled paid shipped returned]
  end

  def categories
    @categories ||= store.categories.by_name
  end

  def retired_products
    @retired_products ||= products.retired
  end

  def admins
    admins ||= store.users
    @admins = admins.reject{|a| a.role == "user" || a.role == "platform_admin"}
  end

  def orders_by_status
    orders_with_status = {}
    store_orders.each do |order|
      if orders_with_status[order.status]
        orders_with_status[order.status] << order
      else
        orders_with_status[order.status] = [order]
      end
    end
    orders_with_status
  end
end
