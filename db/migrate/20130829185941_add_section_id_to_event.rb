class AddSectionIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :section_id, :integer

  end
end
