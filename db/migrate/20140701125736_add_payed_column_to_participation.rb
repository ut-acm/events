class AddPayedColumnToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :payed, :boolean, :default => false
  end
end
