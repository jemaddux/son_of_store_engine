class Order < ActiveRecord::Base

  attr_accessible :status, :user_id, :total_cost, :confirmation, :shipping_id, :billing_id, :card_number

  has_many :line_items, :dependent => :destroy
  belongs_to :user

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil; line_items << item
    end
  end

  def generate_confirmation_code
    (0...6).map{ ('a'..'z').to_a[rand(26)] }.join.upcase
  end


  def self.create_from_cart_for_user(cart, user_id, card_number, shipping_id, billing_id)
    total_cost = cart.calculate_total_cost

    order = Order.new( status:     "pending",
                       user_id:    user_id,
                       total_cost: total_cost,
                       shipping_id: shipping_id,
                       billing_id:  billing_id )

    order.add_line_items(cart)
    order.save_with_payment(card_number)
    order
  end

  def valid_credit_card?(card_number)
    card_number != nil && CreditCardValidator::Validator.valid?(card_number)
  end

  def save_with_payment(card_number)
    if valid_credit_card?(card_number)
      self.status = "paid"
      self.confirmation = generate_confirmation_code
      self.save! 
    end
  end


  def self.find_shipping_address(params, current_user)
    CustomerAddress.create do |a|
      a.street_name  = params[:shipping_street_name]
      a.city         = params[:shipping_city]
      a.state        = params[:shipping_state]
      a.zipcode      = params[:shipping_zipcode]
      a.user_id      = current_user.id
      a.address_type = 'shipping'
    end
  end


  def self.find_billing_address(params, current_user)
    CustomerAddress.create do |a|
      a.street_name  = params[:billing_street_name]
      a.city         = params[:billing_city]
      a.state        = params[:billing_state]
      a.zipcode      = params[:billing_zipcode]
      a.user_id      = current_user.id
      a.address_type = 'billing'
    end
  end
end
