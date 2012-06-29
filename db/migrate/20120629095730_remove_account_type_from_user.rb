class RemoveAccountTypeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :account_type
  end
end
