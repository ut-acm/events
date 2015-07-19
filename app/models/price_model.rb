class PriceModel < ActiveRecord::Base
	belongs_to :event
	has_many :participations
	has_many :coupons
end
