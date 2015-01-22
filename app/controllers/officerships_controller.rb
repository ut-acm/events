class OfficershipsController < ApplicationController
  before_action :set_officership, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  # GET /officerships
  # GET /officerships.json
  def index
    if current_user.nil?
      render 'public/404.html', layout: false
    end
    @officerships = Officership.all
  end

  # GET /officerships/1
  # GET /officerships/1.json
  def show
  end

  # GET /officerships/new
  def new
    @officership = Officership.new
  end

  # GET /officerships/1/edit
  def edit
  end

  # POST /officerships
  # POST /officerships.json
  def create
    @officership = Officership.new(officership_params)
    authorize_action_for @officership
    respond_to do |format|
      if @officership.save
        format.html { redirect_to @officership, notice: 'Officership was successfully created.' }
        format.json { render :show, status: :created, location: @officership }
      else
        format.html { render :new }
        format.json { render json: @officership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /officerships/1
  # PATCH/PUT /officerships/1.json
  def update
    respond_to do |format|
      if @officership.update(officership_params)
        format.html { redirect_to @officership, notice: 'Officership was successfully updated.' }
        format.json { render :show, status: :ok, location: @officership }
      else
        format.html { render :edit }
        format.json { render json: @officership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /officerships/1
  # DELETE /officerships/1.json
  def destroy
    @officership.destroy
    respond_to do |format|
      format.html { redirect_to officerships_url, notice: 'Officership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_officership
      @officership = Officership.find(params[:id])
      authorize_action_for @officership
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def officership_params
      params.require(:officership).permit(:event_id, :profile_id, :description)
    end
end
