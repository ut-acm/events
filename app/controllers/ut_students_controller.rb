class UtStudentsController < ApplicationController
  before_action :set_ut_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin,:only=>[:index, :show, :edit,:update,:destroy]

  def authenticate_admin
    redirect_to events_path if !(current_user and current_user.has_role?(:admin))
  end

  # GET /ut_students
  # GET /ut_students.json
  def index
    @ut_students = UtStudent.all
  end

  # GET /ut_students/1
  # GET /ut_students/1.json
  def show
  end

  # GET /ut_students/new
  def new
    @ut_student = UtStudent.new
  end

  # GET /ut_students/1/edit
  def edit
  end

  def validate_token
      if current_user.ut_student && !current_user.ut_student.validated && current_user.ut_student.token==params[:token]
        Rails.logger.info "::::::::::::::::::::::::::::::::::::::::::::#{current_user.ut_student},#{current_user.ut_student.validated}"
        current_user.ut_student.update(:validated=>true)
        UserMailer.send_coupons(current_user.ut_student.email,PriceModel.find(9)).deliver
        render 'ut_students/success_validate'
      else
        raender 'ut_students/fail_validate'
      end
  end

  # POST /ut_students
  # POST /ut_students.json
  def create
    @ut_student = UtStudent.new(ut_student_params)
    @ut_student.token=SecureRandom.urlsafe_base64
    @ut_student.user=current_user
    @ut_student.validated=false

    respond_to do |format|
      if @ut_student.save
        UserMailer.send_ut_validation(current_user).deliver
        
        format.html { redirect_to events_path, notice: 'ایمیل شما ثبت شد و ایمیلی جهت تایید به شما داده شد.' }
        format.json { render :show, status: :created, location: @ut_student }
      else
        format.html { render :new }
        format.json { render json: @ut_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ut_students/1
  # PATCH/PUT /ut_students/1.json
  def update
    respond_to do |format|
      if @ut_student.update(ut_student_params)
        format.html { redirect_to @ut_student, notice: 'Ut student was successfully updated.' }
        format.json { render :show, status: :ok, location: @ut_student }
      else
        format.html { render :edit }
        format.json { render json: @ut_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ut_students/1
  # DELETE /ut_students/1.json
  def destroy
    @ut_student.destroy
    respond_to do |format|
      format.html { redirect_to ut_students_url, notice: 'Ut student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ut_student
      @ut_student = UtStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ut_student_params
      params.require(:ut_student).permit(:email, :token, :validated)
    end
end
