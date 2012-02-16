class AddStageIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :stage_id, :integer

  end
end
