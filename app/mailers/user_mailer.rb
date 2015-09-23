#!/usr/bin/env ruby
# encoding: utf-8
class UserMailer < ActionMailer::Base
  
  # class variable to hold logo
  @@acm = File.read(Rails.root.join('app', 'assets', 'images', 'acm-logo.png'))
  
  # setting default from
  default from: "ACM Student Chapter"

  def send_qr_reminder(participation)
    recipient = participation.profile.user.email
        subject = "کد ورود شما به رویداد #{participation.event.title}"
        attachments.inline['acm.png'] = @@acm

        puts 'Email: to => ' + recipient + ', subject => ' + subject
        mail(to: recipient, subject: subject) do |format|
          format.html { render 'user_mailer/qr_reminder', :locals => {:token => participation.enroll_token,:participation=>participation} }
        end
  end

  def send_ut_validation(user)
    recipient = user.ut_student.email
        subject = 'اعتبار سنجی ایمیل شما'
        attachments.inline['acm.png'] = @@acm

        puts 'Email: to => ' + recipient + ', subject => ' + subject
        mail(to: recipient, subject: subject) do |format|
          format.html { render 'user_mailer/ut_validation', :locals => {:token => user.ut_student.token} }
    #      format.html { render 'welcome_message' }
        end
  end

  # call this method to send an email
  def welcome(user)
    recipient = user.email
    subject =
        'به شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران خوش آمدید'
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'welcome_message' }
#      format.html { render 'welcome_message' }
    end
  end
  def start_register(profile, event)
    recipient = profile.user.email
    subject =
    'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
        'آغاز ثبت نام رویداد ' + event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'start_register', :locals => {:profile => profile, :event => event,:price=>invoice.participation.get_price} }
#      format.html { render 'welcome_message' }
    end
  end
  def complete_payment(payment)
    recipient = payment.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'پرداخت '
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/complete_payment', :locals => {:profile => payment.profile, :amount => payment.amount} }
#      format.html { render 'welcome_message' }
    end
  end
  def complete_invoice(invoice)
    recipient = invoice.participation.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -'
        if participation.event.category=="Product"
          subject=subject+'صورت‌حساب خرید محصول '
        else
          subject=subject+'صورت‌حساب ثبت‌نام رویداد '
        end
        subject=subject+invoice.participation.event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/complete_invoice', :locals => {:profile => invoice.participation.profile, :event => invoice.participation.event,:price=>invoice.participation.get_price} }
#      format.html { render 'welcome_message' }
    end
  end

  def book_event(participation)
    recipient = participation.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'رویداد '+
            participation.event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/book_event', :locals => {:profile => participation.profile, :event => participation.event,:price=>invoice.participation.get_price} }
#      format.html { render 'welcome_message' }
    end
  end

  def send_all_register(profile)
    recipient = profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'راه‌اندازی پرداخت الکترونیکی و ثبت‌نام رویدادها'

    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/send_all_register', :locals => {:profile => profile} }
#      format.html { render 'welcome_message' }
    end

  end

  def send_coupons(email,price_model)
    coupons=price_model.coupons.to_a
    subject="کد تخفیف رویداد #{price_model.event.title} برای شما!"
      attachments.inline['acm.png'] = @@acm
      recipient = email
      code=price_model.create_a_coupon
      puts 'Email: to => ' + recipient + ', subject => ' + subject
      mail(to: recipient, subject: subject) do |format|
        format.html { render 'user_mailer/coupons', :locals => {:event => price_model.event,:price_model=>price_model,:cut_code=>code} }
      end
  end

  def remind_event(event)
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'یادآوری کلاس '+event.title
    event.participations.each do |p|
      recipient = p.profile.user.email

      attachments.inline['acm.png'] = @@acm

      puts 'Email: to => ' + recipient + ', subject => ' + subject
      mail(to: recipient, subject: subject) do |format|
        format.html { render 'user_mailer/remind_event', :locals => {:profile => p.profile,:event=>event} }
      end
    end
  end
end