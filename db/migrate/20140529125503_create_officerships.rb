class CreateOfficerships < ActiveRecord::Migration
  def change
    create_table :officerships do |t|
      t.integer :event_id
      t.integer :profile_id
      t.text :description

      t.timestamps
    end
  end
end
