class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description, :status, :user_id
  has_many :categories
  has_many :products
  has_many :users
  has_many :orders

  validates :name, :uniqueness => {:case_sensitive => false}
  validates :path, :uniqueness => {:case_sensitive => false}

  def self.find_store_users(store_id)
    store = find_by_id(store_id)
    store.users.reject { |user| user.role != "admin" }
  end

end
