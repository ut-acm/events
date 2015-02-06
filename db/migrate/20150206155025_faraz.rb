class Faraz < ActiveRecord::Migration
  def change
	add_column :prfiles, :phone_number, :string
	add_column :prfiles, :rating, :integer,:default => 0
	add_column :events, :report_id, :integer
  end
end

