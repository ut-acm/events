class ClassSessionsController < ApplicationController
  before_action :authenticate_user!, :only => [:book, :cancel_book, :edit, :new]
  before_action :set_class_session, only: [:show, :edit, :update, :destroy]

  # GET /class_sessions
  # GET /class_sessions.json
  def index
    if current_user and current_user.has_role?(:admin)
      @class_sessions = ClassSession.all.order(:start_time)
    else
      redirect_to events_path
    end
  end

  # GET /class_sessions/1
  # GET /class_sessions/1.json
  def show
    authorize_action_for @class_session
  end

  # GET /class_sessions/new
  def new
    @class_session = ClassSession.new
  end

  # GET /class_sessions/1/edit
  def edit
  end

  # POST /class_sessions
  # POST /class_sessions.json
  def create

    #for i in 1..params.require(:class_session)[:weeks]
    #
    #end
    start_time = params[:class_session]["start_time(1i)"]
    start_time = DateTime.new(params[:class_session]["start_time(1i)"].to_i,
                              params[:class_session]["start_time(2i)"].to_i,
                              params[:class_session]["start_time(3i)"].to_i,
                              params[:class_session]["start_time(4i)"].to_i,
                              params[:class_session]["start_time(5i)"].to_i)
    week_count = 1
    if params[:weeks]
      week_count = params[:weeks].to_i
    end
    for i in 1..week_count
      puts start_time
      @class_session = ClassSession.new(class_session_params_without_start_time)
      @class_session.start_time = start_time
      authorize_action_for @class_session
      @class_session.save
      start_time += 7.day
    end
    redirect_to @class_session, notice: 'Class session was successfully created.'
    #respond_to do |format|
    #  if @class_session.save
    #    format.html { redirect_to @class_session, notice: 'Class session was successfully created.' }
    #    format.json { render :show, status: :created, location: @class_session }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @class_session.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /class_sessions/1
  # PATCH/PUT /class_sessions/1.json
  def update
    authorize_action_for @class_session
    respond_to do |format|
      if @class_session.update(class_session_params)
        format.html { redirect_to @class_session, notice: 'Class session was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_session }
      else
        format.html { render :edit }
        format.json { render json: @class_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_sessions/1
  # DELETE /class_sessions/1.json
  def destroy
    authorize_action_for @class_session
    @class_session.destroy
    respond_to do |format|
      format.html { redirect_to class_sessions_url, notice: 'Class session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_session
      @class_session = ClassSession.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_session_params
      params.require(:class_session).permit(:event_id, :duration, :start_time)
    end
    def class_session_params_without_start_time
      params.require(:class_session).permit(:event_id, :duration)
    end

end
