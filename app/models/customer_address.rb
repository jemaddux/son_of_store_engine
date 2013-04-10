class CustomerAddress < ActiveRecord::Base
  attr_accessible :user_id, :street_name, :zipcode, :city, :state, :type

  def self.create_address(params,type)
    create(user_id: current_user.id, street_name: 
        params["shipping_street_name"], zipcode: 
        params["shipping_zipcode"], city: 
        params["shipping_city"], state: 
        params["shipping_state"], type: type)
  end
end
