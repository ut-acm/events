class Coupon < ActiveRecord::Base
	belongs_to :price_model
	has_many :participations
end
