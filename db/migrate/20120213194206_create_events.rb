class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :orig_title
      t.text :description
      t.string :event_type
      t.text :info
      t.string :poster
      t.string :trailer

      t.timestamps
    end
  end
end
