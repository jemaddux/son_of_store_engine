class AddSessionAndStoreIdsToCart < ActiveRecord::Migration
  def change
    add_column :carts, :session_id, :integer
    add_index :carts, :session_id
    add_column :carts, :store_id, :integer
    add_index :carts, :store_id
  end
end
