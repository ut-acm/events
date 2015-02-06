class Faraz < ActiveRecord::Migration
  def change
	add column :prfiles, :phone_number, :string
	add column :prfiles, :rating, :integer,:default => 0
	add column :events, :report_id, :integer
  end
end

