#!/usr/bin/env ruby
# encoding: utf-8
class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    if current_user.has_role?(:admin)
      @payments = Payment.all.order(:created_at).reverse_order
    else
      @payments = current_user.profile.payments.order(:created_at).reverse_order
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @profile = current_user.profile
  end

  # GET /payments/1/edit
  def edit
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
  end


  require "net/http"
  require "uri"

  def transact(uri, parameters)
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request.set_form_data(parameters)
      response = http.request request
    end
  end


  # POST /payments
  # POST /payments.json
  def create
    @profile = current_user.profile
    @payment = Payment.new(payment_params)
    @payment.profile = current_user.profile
    if @payment.save
      uri = URI('http://acm.ut.ac.ir/epayment/payments')
      parameters = {
          'merchant' => "4452A141",
          'amount' => @payment.amount,
          'redirect' => "http://acm.ut.ac.ir/events/payments/approve"}
      response = transact(uri, parameters)
      puts response.body
      @payment.response = response.body
      parsed_response = JSON.parse(response.body)
      if parsed_response["status"] != 1
        redirect_to payments_path, notice: "در ارتباط با بانک خطایی رخ داده‌است."
        return
      end
      @payment.reference_key = parsed_response["reference"]
      if @payment.save
        redirect_to parsed_response["bank"]
        return
      else
        render :new
      end
    else
      render :new
    end

  end

  def approve
    #puts "Approve"
    #puts "params"
    #puts params
    #puts params["reference"]
    #puts params["successful"]
    #puts approve_params
    if approve_params["reference"].empty? or approve_params["successful"].empty?
      redirect_to payments_path, :notice => "اطلاعات پرداخت اشتباه است."
      return
    end
    #puts "REF-key"
    #puts approve_params["reference"]
    #puts "successful"
    #puts approve_params["successful"]
    @payment = Payment.where("reference_key = ?", approve_params["reference"]).where("status = ?", false).first
    #puts "Is nill? " + @payment.nil?.to_s
    if @payment.nil?
      redirect_to payments_path, notice: 'در فرآیند پرداخت مشکلی به وجود آمد.'
      return
    end
    # mohammad #############################
    uri = URI("http://acm.ut.ac.ir/epayment/payments/lookup?merchant=4452A141&reference=#{approve_params['reference']}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
      result = JSON.parse(response.body)
      if result['status'] != 1 or !result['successful']
        redirect_to payments_path, notice: 'فرایند پرداخت با خطا روبرو شد.'
        return
      end
    end
    ########################################

    @profile = @payment.profile
    @profile.credit += @payment.amount
    @profile.save
    @payment.status = true
    @payment.succeed_time = Time.now
    @payment.save
    UserMailer.complete_payment(@payment).deliver
    render 'payments/approve'
    #redirect_to payments_path, notice: 'پرداخت با موفقیت انجام شد.'
  end

  def create_other_site
    @profile = Profile.where(:surname=>"PayIt").first
    @payment = Payment.new(:amount=>300000)
    @payment.payer=Payer.find(params[:payit_id])
    @payment.profile = @profile
    if @payment.save
      uri = URI('http://acm.ut.ac.ir/epayment/payments')
      parameters = {
          'merchant' => "4452A141",
          'amount' => @payment.amount,
          'redirect' => approve_payit_path(params[:payit_id])}
      response = transact(uri, parameters)
      puts response.body
      @payment.response = response.body
      parsed_response = JSON.parse(response.body)
      if parsed_response["status"] != 1
        redirect_to payments_path, notice: "در ارتباط با بانک خطایی رخ داده‌است."
        return
      end
      @payment.reference_key = parsed_response["reference"]
      if @payment.save
        redirect_to parsed_response["bank"]
        return
      else
        render new_payer_path
      end
    else
      render new_payer_path
    end

  end

  def approve_other_site
    #puts "Approve"
    #puts "params"
    #puts params
    #puts params["reference"]
    #puts params["successful"]
    #puts approve_params
    if approve_params["reference"].empty? or approve_params["successful"].empty?
      redirect_to payer_fail_path
      return
    end
    #puts "REF-key"
    #puts approve_params["reference"]
    #puts "successful"
    #puts approve_params["successful"]
    @payment = Payment.where("reference_key = ?", approve_params["reference"]).where("status = ?", false).first
    #puts "Is nill? " + @payment.nil?.to_s
    if @payment.nil?
      redirect_to payer_fail_path
      return
    end
    # mohammad #############################
    uri = URI("http://acm.ut.ac.ir/epayment/payments/lookup?merchant=4452A141&reference=#{approve_params['reference']}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
      result = JSON.parse(response.body)
      if result['status'] != 1 or !result['successful']
        redirect_to payer_fail_path
        return
      end
    end
    ########################################

    @profile = @payment.profile
    @profile.credit += @payment.amount
    @profile.save
    @payment.status = true
    @payment.succeed_time = Time.now
    @payment.save
    UserMailer.complete_payment(@payment).deliver
    redirect_to payer_success_path
    #redirect_to payments_path, notice: 'پرداخت با موفقیت انجام شد.'
  end

  def other_suc
  end
  def other_fail
  end


  def manual_new
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @payment = Payment.new
    render 'payments/manual_new'
  end

  def manual_create
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @payment = Payment.new(manual_payment_params)
    if @payment.save
     redirect_to payments_path
    else
      render :manual_new
    end
  end

  def manual_approve
    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @payment = Payment.find(params[:id])
    if @payment.nil?
      redirect_to events_path
      return
    end
    if @payment.reference_key != "manual"
      redirect_to events_path
      return
    end
    @profile = @payment.profile
    @profile.credit += @payment.amount
    @profile.save
    @payment.status = true
    @payment.succeed_time = Time.now
    @payment.save
    #UserMailer.complete_payment(@payment).deliver
    redirect_to payments_path, :notice => "مبلغ تایید شد"
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
#TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end

    respond_to do |format|
      if @payment.update(manual_payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy

    #TODO
    if !current_user.has_role?(:admin)
      redirect_to events_path
      return
    end
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      #params.require(:payment).permit(:amount, :profile_id, :reference_key, :status, :succeed_time)
      params.require(:payment).permit(:amount)
    end
    def manual_payment_params
      params.require(:payment).permit(:amount, :profile_id, :reference_key)
      #params.require(:payment).permit(:amount)
    end
  def approve_params
    params.permit(:reference, :successful)
  end
end
