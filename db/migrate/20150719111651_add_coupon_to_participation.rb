class AddCouponToParticipation < ActiveRecord::Migration
  def change
  	add_column :participations, :coupon_id, :integer
  end
end
