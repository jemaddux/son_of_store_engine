class OrderProcessor 

  def self.process_order(params, cart, new_order_user, current_user)
    Order.create_from_cart_for_user(cart,
                                    new_order_user.id,
                                    params[:card_number],
                                    shipping_id(params, current_user),
                                    billing_id(params, current_user),
                                    cart.store_id)
  end

  def self.shipping_id(params, current_user)
    Order.shipping_address(params, current_user).id
  end

  def self.billing_id(params, current_user)
    Order.billing_address(params, current_user).id
  end
end