class Coupon < ActiveRecord::Base
	belongs_to :price_model
	has_many :participations
	validates_uniqueness_of :cut_code
end
