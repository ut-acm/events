class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
    	t.text :body
    	t.integer :event_id

      t.timestamps
    end
  end
end
