class AddSubdomainToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :subdomain, :string

  end
end
