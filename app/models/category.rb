class Category < ActiveRecord::Base
  attr_accessible :name, :category_ids, :store_id

  belongs_to :store
  
  has_many :product_categories
  has_many :products, :through => :product_categories
  scope :by_name, order("name asc")
end
