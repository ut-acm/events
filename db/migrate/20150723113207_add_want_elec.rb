class AddWantElec < ActiveRecord::Migration
  def change
  	add_column :payers, :want_elec, :boolean
  end
end
