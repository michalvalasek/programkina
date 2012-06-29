class AddAccountTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string, :limit => 10
  end
end
