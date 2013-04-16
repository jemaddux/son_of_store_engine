class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description, :status, :user_id

  has_many :categories

  has_many :products

  validates :name, :uniqueness => {:case_sensitive => false}
  validates :path, :uniqueness => {:case_sensitive => false}

end
