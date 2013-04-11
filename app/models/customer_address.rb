class CustomerAddress < ActiveRecord::Base

  attr_accessible :street_name, :city, :state, :zipcode, :user_id, :address_type

end
