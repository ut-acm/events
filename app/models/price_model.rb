class PriceModel < ActiveRecord::Base
	belongs_to :event
	has_many :participations
	has_many :coupons

	def create_coupons(n)
		i=0
		loop do
			break if i==n
			c=Coupon.new(:cut_code=>SecureRandom.urlsafe_base64,:price_model=>self,:enabled=>true)
			i+=1 if c.save
		end
	end
end
