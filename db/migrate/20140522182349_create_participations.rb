class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :event
      t.references :profile
      t.timestamps
    end
  end
end
