class Faraz < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :phone_number
  		t.integer :rating, :default => 0
  	end
  	create_table :events do |t|
  		t.integer :report_id
  	end
  end
end
