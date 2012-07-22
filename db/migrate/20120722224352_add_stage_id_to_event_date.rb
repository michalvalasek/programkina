class AddStageIdToEventDate < ActiveRecord::Migration
  # class EventDate < ActiveRecord::Base
  # end
  
  def change
    add_column :event_dates, :stage_id, :integer
    
    #update data
    EventDate.reset_column_information
    EventDate.all.each do |ed|
      ed.update_attributes!(:stage_id => ed.event.stage.id)
    end
  end
end
