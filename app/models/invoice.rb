class Invoice < ActiveRecord::Base
  belongs_to :participation
  validate :check_credit
  validate :check_capacity

  after_create :send_invoice

  def check_credit
    if participation.profile.credit < participation.event.price
      errors.add(:credit, "اعتبار شما کافی نیست، لطفا برای افزایش اعتبار به صفحه‌ی تنظیمات مراجعه کنید.")
    end
  end

  def check_capacity
    if participation.event.is_full?
      errors.add(:full, "رویداد مورد نظر پر شده‌است.")
    end
  end


  def send_invoice
    UserMailer.complete_invoice(self).deliver
    puts "invoice message send"
  end

end
