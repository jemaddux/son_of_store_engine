class Cart < ActiveRecord::Base
  attr_accessible :store_id, :session_id
  
  has_many :line_items, :dependent => :destroy

  belongs_to :session
  belongs_to :store

  def add_product(product)
    current_item = line_items.where(:product_id => product.id).first
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id,
                price: product.price)
    end
    current_item
  end

  def calculate_total_cost
    line_items.map { |item| item.total }.inject(0, :+)
  end


  def self.find_current_cart(session, store)
    @cart = session && Session.find(session).carts.find_by_store_id(store.id)
  end
end
