require 'digest'
class WavesController < ApplicationController
  require 'digest'
  before_action :set_wave, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == 'c8bad41e1002c9972696a22dc4ee3681'
    end
  end
  # GET /waves
  # GET /waves.json
  def index
    @waves = Wave.all.reverse
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


  #lists ALL the deleted Waves in order so that we can undo
  def undolist
    @waves = Wave.only_deleted.reverse
  end

  #controller to fully delete a Wave
  def undo_deletion
    Wave.only_deleted.find(params[:id]).restore

    respond_to do |format|
      format.html { redirect_to waves_url, notice: 'Wave was successfully recovered.' }
      format.json { head :no_content }
    end
  end

  #controller to fully delete a Wave
  def really_delete
    Wave.only_deleted.find(params[:id]).really_destroy!

    respond_to do |format|
      format.html { redirect_to waves_url, notice: 'Wave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def auto
    @waves = Wave.all
    @new_wave = Wave.new

    # Current time
    Time.zone = "Singapore"
    time_now = Time.zone.now

    # Edit the new_wave to be added to the database
    if @waves.blank?
      @new_wave.wave_number = 1
    else
      @new_wave.wave_number = @waves.last.wave_number + 1
    end
    @new_wave.start_time = time_now
    @new_wave.created_at = time_now
    @new_wave.updated_at = time_now

    respond_to do |format|
      if @new_wave.save
        format.html { redirect_to @new_wave, notice: 'Wave was successfully created.' }
        format.json { render :show, status: :created, location: @new_wave }
      else
        format.html { render :new }
        format.json { render json: @new_wave.errors, status: :unprocessable_entity }
      end
    end
  end


  def update_nums
    @waves = Wave.all
    @new_waves = @waves.sort_by { |x| [x.start_time] }

    counter = 1
    @new_waves.each do |new_wave|
      new_wave.update_attribute(:wave_number, counter)
      counter = counter + 1
    end
  render plain: @new_waves.inspect

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
