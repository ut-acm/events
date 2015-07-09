#!/usr/bin/env ruby
# encoding: utf-8
class Participation < ActiveRecord::Base
  validate :check_capacity
  belongs_to :profile
  belongs_to :event
  has_one :invoice
  belongs_to :price_model

  def buy (profile)
    if self.profile == profile and self.payed == false and Invoice.joins(:participation).merge(Participation.where("profile_id = ?", self.profile.id).where("event_id = ?", self.event.id)).count == 0
    #if true
      invoice = Invoice.create(:participation => self, :amount => self.get_price)
      if invoice.errors.blank?
        self.payed = true
        self.save
        profile.credit -= self.get_price
        profile.save
        return true
      end
      # Rails.logger.info "::::::::::::::::::::::::::::::::::::::::::::#{invoice.errors.messages.first}"
      # puts ":::::::::::::::::::::::::::::::::::::::::::::::::"
      # puts invoice.errors.messages
      return false
    end
    return false
  end

  def get_price
    return participation.price_model.price if participation.event.is_conference_like
    return participation.event.price
  end

  def check_credit
    if profile.credit < self.get_price
      errors.add(:credit, "اعتبار شما کافی نیست، لطفا برای افزایش اعتبار به صفحه‌ی تنظیمات مراجعه کنید.")
    end
  end

  def check_capacity
    if event.is_full?
      errors.add(:event, "is full!")
    end
  end

  def notify_book
    p = self
    puts p
    puts p.event.title
    puts p.profile.credentials
    UserMailer.book_event(p).deliver
    #puts "S"
  end
  handle_asynchronously :notify_book

end
