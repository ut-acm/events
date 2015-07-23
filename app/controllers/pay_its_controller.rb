class PayItsController < ApplicationController
  before_action :set_pay_it, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin ,:only=>[:show, :edit, :update, :destroy]

  def authenticate_admin
    redirect_to events_path if !(current_user and current_user.has_role?(:admin))
  end

  # GET /pay_its
  # GET /pay_its.json
  def index
    @pay_its = PayIt.all
  end

  # GET /pay_its/1
  # GET /pay_its/1.json
  def show
  end

  # GET /pay_its/new
  def new
    @pay_it = PayIt.new
  end

  # GET /pay_its/1/edit
  def edit
  end

  # POST /pay_its
  # POST /pay_its.json
  def create
    @pay_it = PayIt.new(:name=>params[:pay_it][:name], :surname=>params[:pay_it][:surname], :mobile=>params[:pay_it][:mobile], :email=>params[:pay_it][:email], :grades_image=>params[:pay_it][:grades_image], :region_type=>params[:pay_it][:region_type], :exam_regional_rank=>params[:pay_it][:exam_regional_rank], :exam_overall_rank=>params[:pay_it][:exam_overall_rank], :city=>params[:pay_it][:city], :school=>params[:pay_it][:school])
    Rails.logger.info "::::::::::::::::::::::::::::#{@pay_it} #{@pay_it.nil?} #{@pay_it.id.nil?} #{@pay_it.name.nil?} #{@pay_it.name}"
    if @pay_it.save
      redirect_to bank_payit_path(@pay_it.id)
    end
    # respond_to do |format|
    #   if @pay_it.save
    #     # format.html { redirect_to @pay_it, notice: 'Pay it was successfully created.' }
    #     # format.json { render :show, status: :created, location: @pay_it }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @pay_it.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /pay_its/1
  # PATCH/PUT /pay_its/1.json
  def update
    respond_to do |format|
      if @pay_it.update(pay_it_params)
        format.html { redirect_to @pay_it, notice: 'Pay it was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_it }
      else
        format.html { render :edit }
        format.json { render json: @pay_it.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_its/1
  # DELETE /pay_its/1.json
  def destroy
    @pay_it.destroy
    respond_to do |format|
      format.html { redirect_to pay_its_url, notice: 'Pay it was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_it
      @pay_it = PayIt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_it_params
      params.require(:pay_it).permit(:name, :surname, :mobile, :email, :grades_image, :region_type, :exam_regional_rank, :exam_overall_rank, :city, :school)
    end
end
