class RenameAddressTypeColumn < ActiveRecord::Migration
  def change
    change_table :customer_addresses do |t|
      t.rename :type, :address_type
    end
  end
end
