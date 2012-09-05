class AddNotificationToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :notification, :string

  end
end
