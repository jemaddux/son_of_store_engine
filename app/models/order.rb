class Order < ActiveRecord::Base

  attr_accessible :status, :user_id, :total_cost, :confirmation, :shipping_id, :billing_id, :card_number
  attr_accessible :confirmation_hash, :store_id

  has_many :line_items, :dependent => :destroy
  belongs_to :user
  belongs_to :store

  attr_accessor :card_number

  validate :validate_credit_card

  def update_status(status)
    self.status = status
    self.card_number = self.card_number || "4242424242424242"
    self.save!
  end

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil; line_items << item
    end
  end

  def generate_confirmation_code
    (0...6).map{ ('a'..'z').to_a[rand(26)] }.join.upcase
  end

  def self.generate_confirmation_hash
    a = UUID.new
    a.generate
  end


  def self.create_from_cart_for_user(cart, user_id, card_number, shipping_id, billing_id, store_id)
    total_cost = cart.calculate_total_cost

    order = Order.new( status:     "pending",
                       user_id:    user_id,
                       total_cost: total_cost,
                       shipping_id: shipping_id,
                       billing_id:  billing_id,
                       confirmation_hash: generate_confirmation_hash,
                       card_number: card_number,
                       store_id: store_id)

    order.add_line_items(cart)
    order.card_number = card_number
    order.save_payment(card_number)
    order
  end

  def validate_credit_card
    if card_number == nil
      errors.add(:card_number, "No Card Number Specified")
    elsif !CreditCardValidator::Validator.valid?(card_number)
      errors.add(:card_number, "Invalid Card Number, Sucka!")
    end
  end

  def self.shipping_address(params, user_id)

    CustomerAddress.create do |a|
      a.street_name  = params[:shipping_street_name]
      a.city         = params[:shipping_city]
      a.state        = params[:shipping_state]
      a.zipcode      = params[:shipping_zipcode]
      a.user_id      = user_id
      a.address_type = 'shipping'
    end
  end


  def self.billing_address(params, user_id)

    CustomerAddress.create do |a|
      a.street_name  = params[:billing_street_name]
      a.city         = params[:billing_city]
      a.state        = params[:billing_state]
      a.zipcode      = params[:billing_zipcode]
      a.user_id      = user_id
      a.address_type = 'billing'
    end
  end

  def save_payment(card_number)
    self.status = "paid"
    self.confirmation = generate_confirmation_code
    self.save
  end
end
