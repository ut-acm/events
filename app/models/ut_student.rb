class UtStudent < ActiveRecord::Base
	belongs_to :user
	validate :ut_mail

	def ut_mail
		self.errors.add(:email=>"ایمیل دانشگاه را وراد کنید.") unless self.email.ends_with?("@ut.ac.ir")
	end
end
