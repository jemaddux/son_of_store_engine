class AddStoreIndexToCategories < ActiveRecord::Migration
  def change
    add_index :categories, :store_id
  end
end
