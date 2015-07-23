class Payment < ActiveRecord::Base
  belongs_to :profile
  has_one :payer
  validates :amount, :numericality => { :greater_than_or_equal_to => 10000 }

  #after_create :send_payment


  #def send_payment
  #  if self.status
  #    UserMailer.complete_payment(self).deliver
  #    puts "payment message send"
  #  end
  #end
end
