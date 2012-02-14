class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.string :date
      t.datetime :datetime

      t.timestamps
    end
  end
end
