class AddProjectionTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :projection_type, :string

  end
end
