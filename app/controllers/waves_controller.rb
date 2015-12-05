class WavesController < ApplicationController
  before_action :set_wafe, only: [:show, :edit, :update, :destroy]

  # GET /waves
  # GET /waves.json
  def index
    @waves = Wave.all
  end

  # GET /waves/1
  # GET /waves/1.json
  def show
  end

  # GET /waves/new
  def new
    @wafe = Wave.new
  end

  # GET /waves/1/edit
  def edit
  end

  # POST /waves
  # POST /waves.json
  def create
    @wafe = Wave.new(wafe_params)

    respond_to do |format|
      if @wafe.save
        format.html { redirect_to @wafe, notice: 'Wave was successfully created.' }
        format.json { render :show, status: :created, location: @wafe }
      else
        format.html { render :new }
        format.json { render json: @wafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waves/1
  # PATCH/PUT /waves/1.json
  def update
    respond_to do |format|
      if @wafe.update(wafe_params)
        format.html { redirect_to @wafe, notice: 'Wave was successfully updated.' }
        format.json { render :show, status: :ok, location: @wafe }
      else
        format.html { render :edit }
        format.json { render json: @wafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waves/1
  # DELETE /waves/1.json
  def destroy
    @wafe.destroy
    respond_to do |format|
      format.html { redirect_to waves_url, notice: 'Wave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wafe
      @wafe = Wave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wafe_params
      params.require(:wafe).permit(:wave_number, :start_time)
    end
end
