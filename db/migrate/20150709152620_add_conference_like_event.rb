class AddConferenceLikeEvent < ActiveRecord::Migration
  def change
  	add_column :events, :is_conference_like, :bool
  end
end
