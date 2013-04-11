class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description, :status
  validates :name, :uniqueness => {:case_sensitive => false}
  validates :path, :uniqueness => {:case_sensitive => false}
end
