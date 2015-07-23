class Payer < ActiveRecord::Base
	belongs_to :payment
	validate :check_mobile
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,:message=>"ایمیل صحیح نیست"
	validate :check_rank
	validates :name,:surname,:mobile,:email,:region_type,:exam_regional_rank,:exam_overall_rank,:city,:school, presence: true, allow_blank: false,:message=>"پر کردن تمام فیلدها اجباری است."

	def check_mobile
		self.errors.add(:mobile,'موبایل صحیح نیست') unless (self.mobile.starts_with?("09") and self.mobile.size==10)
	end

	def check_rank
		self.errors.add(:exam_regional_rank,'رتبه منطقه عددی مثبت است') unless self.exam_regional_rank>0
		self.errors.add(:exam_overall_rank,'رتبه کشوری عددی مثبت است') unless self.exam_overall_rank>0
	end
end
