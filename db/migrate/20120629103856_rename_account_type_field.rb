class RenameAccountTypeField < ActiveRecord::Migration
  def change
    rename_column :accounts, :type, :account_type
  end
end
