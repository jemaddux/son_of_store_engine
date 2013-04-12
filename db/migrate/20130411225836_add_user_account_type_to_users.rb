class AddUserAccountTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string, :default => "active"
  end
end
