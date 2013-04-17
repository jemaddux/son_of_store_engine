class AddStoreIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :store_id
  end
end
