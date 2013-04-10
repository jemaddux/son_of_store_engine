class CustomerAddress < ActiveRecord::Base

  attr_accessible :street_name, :city, :state, :zipcode, :user_id, :address_type

  def self.shipping_address(params, current_user)
    CustomerAddress.create do |a|
      a.street_name  = params[:shipping_street_name]
      a.city         = params[:shipping_city]
      a.state        = params[:shipping_state]
      a.zipcode      = params[:shipping_zipcode]
      a.user_id      = current_user.id
      a.address_type = 'shipping'
    end
  end


  def self.billing_address(params, current_user)
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
