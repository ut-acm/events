class UtStudent < ActiveRecord::Base
	belongs_to :user
	validate :ut_mail

	def ut_mail
		self.errors.add(:mail=>"ایمیل دانشگاه را وراد کنید.") unless mail.ends_with?("@ut.ir")
	end
end
