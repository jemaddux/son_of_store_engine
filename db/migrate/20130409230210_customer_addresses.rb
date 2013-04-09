class CustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.references  :user
      t.string      :street_name
      t.string      :zipcode
      t.string      :city
      t.string      :state
      t.string      :type
      t.timestamps
    end

    add_index :customer_addresses, :user_id
  end
end
