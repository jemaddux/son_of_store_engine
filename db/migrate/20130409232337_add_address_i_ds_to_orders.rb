class AddAddressIDsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_id, :integer
    add_column :orders, :billing_id,  :integer
  end
end
