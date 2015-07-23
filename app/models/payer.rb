class Payer < ActiveRecord::Base
	belongs_to :payment
	# validate :check_mobile
	# validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,:message=>"ایمیل صحیح نیست"
	# validate :check_rank
	# validate :be_present

	def be_present
		unless self.name and self.surname and self.mobile and self.email and self.region_type and self.exam_regional_rank and self.exam_overall_rank and self.city and self.school
			self.errors.add(:base,"پر کردن تمام فیلدها اجباری است.")
		end
	end

	def check_mobile
		return unless self.check_mobile
		self.errors.add(:mobile,'موبایل صحیح نیست') unless (self.mobile.starts_with?("09") and self.mobile.size==10)
	end

	def check_rank
		return unless self.exam_overall_rank and self.exam_overall_rank
		self.errors.add(:exam_regional_rank,'رتبه منطقه عددی مثبت است') unless self.exam_regional_rank>0
		self.errors.add(:exam_overall_rank,'رتبه کشوری عددی مثبت است') unless self.exam_overall_rank>0
	end
end
