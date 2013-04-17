class OrderProcessor 

  def self.process_order(params, cart, new_order_user)
    Order.create_from_cart_for_user(cart,
                                    new_order_user.id,
                                    params[:card_number],
                                    shipping_id(params, new_order_user),
                                    billing_id(params, new_order_user),
                                    cart.store_id)
  end

  def self.finalize_order_process(cart, new_order_user, order, current_session)
    Resque.enqueue(SendConfirmationEmail, new_order_user.email, order.confirmation, order.confirmation_hash)
    destroy_current_session!(cart.id, current_session)
  end

  def self.shipping_id(params, new_order_user)
    CustomerAddress.shipping_address(params, new_order_user).id
  end

  def self.billing_id(params, new_order_user)
    CustomerAddress.billing_address(params, new_order_user).id
  end

  def self.destroy_current_session!(cart_id, current_session)
     puts current_session.carts.find_by_id(cart_id).inspect
    current_session.carts.find_by_id(cart_id).destroy if current_session.carts.find_by_id(cart_id)
    puts current_session.carts.find_by_id(cart_id).inspect
  end
end