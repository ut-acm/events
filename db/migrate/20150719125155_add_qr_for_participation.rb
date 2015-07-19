class AddQrForParticipation < ActiveRecord::Migration
  def change
  	add_column :participations, :enroll_token, :text
  	add_column :participations, :enroll_seen, :boolean
  end
end
