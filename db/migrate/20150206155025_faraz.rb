class Faraz < ActiveRecord::Migration
  def change
	add_column :profiles, :phone_number, :string
	add_column :profiles, :rating, :integer,:default => 0
	add_column :events, :report_id, :integer
  end
end

