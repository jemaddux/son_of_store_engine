class AddUniqueConfirmationHashToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmation_hash, :string
  end
end
