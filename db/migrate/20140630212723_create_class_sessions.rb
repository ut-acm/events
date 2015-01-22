class CreateClassSessions < ActiveRecord::Migration
  def change
    create_table :class_sessions do |t|
      t.integer :event_id
      t.integer :duration
      t.datetime :start_time

      t.timestamps
    end
  end
end
