class PriceModelsController < ApplicationController
  before_action :set_price_model, only: [:show, :edit, :update, :destroy]

  # GET /price_models
  # GET /price_models.json
  def index
    @price_models = PriceModel.all
  end

  # GET /price_models/1
  # GET /price_models/1.json
  def show
  end

  # GET /price_models/new
  def new
    @price_model = PriceModel.new
  end

  # GET /price_models/1/edit
  def edit
  end

  # POST /price_models
  # POST /price_models.json
  def create
    @price_model = PriceModel.new(price_model_params)

    respond_to do |format|
      if @price_model.save
        format.html { redirect_to @price_model, notice: 'Price model was successfully created.' }
        format.json { render :show, status: :created, location: @price_model }
      else
        format.html { render :new }
        format.json { render json: @price_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_models/1
  # PATCH/PUT /price_models/1.json
  def update
    respond_to do |format|
      if @price_model.update(price_model_params)
        format.html { redirect_to @price_model, notice: 'Price model was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_model }
      else
        format.html { render :edit }
        format.json { render json: @price_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_models/1
  # DELETE /price_models/1.json
  def destroy
    @price_model.destroy
    respond_to do |format|
      format.html { redirect_to price_models_url, notice: 'Price model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_model
      @price_model = PriceModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_model_params
      params.require(:price_model).permit(:price, :name, :event_id)
    end
end
