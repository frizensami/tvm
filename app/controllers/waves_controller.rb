class WavesController < ApplicationController
  before_action :set_wave, only: [:show, :edit, :update, :destroy]

  # GET /waves
  # GET /waves.json
  def index
    @waves = Wave.all
    @wave = Wave.new
  end

  # GET /waves/1
  # GET /waves/1.json
  def show
  end

  # GET /waves/new
  def new
    @wave = Wave.new
  end

  # GET /waves/1/edit
  def edit
  end

  # POST /waves
  # POST /waves.json
  def create
    @wave = Wave.new(wave_params)

    respond_to do |format|
      if @wave.save
        format.html { redirect_to @wave, notice: 'Wave was successfully created.' }
        format.json { render :show, status: :created, location: @wave }
      else
        format.html { render :new }
        format.json { render json: @wave.errors, status: :unprocessable_entity }
        format.js { render json: @wave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waves/1
  # PATCH/PUT /waves/1.json
  def update
    respond_to do |format|
      if @wave.update(wave_params)
        format.html { redirect_to @wave, notice: 'Wave was successfully updated.' }
        format.json { render :show, status: :ok, location: @wave }
      else
        format.html { render :edit }
        format.json { render json: @wave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waves/1
  # DELETE /waves/1.json
  def destroy
    @wave.destroy
    respond_to do |format|
      format.html { redirect_to waves_url, notice: 'Wave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wave
      @wave = Wave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wave_params
      params.require(:wave).permit(:wave_number, :start_time)
    end
end
