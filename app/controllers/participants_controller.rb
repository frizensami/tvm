require 'digest'
class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == 'c8bad41e1002c9972696a22dc4ee3681'
    end
  end
  # GET /participants
  # GET /participants.json
  def index
    #@participants = Participant.all
    @participants = Participant.all.reverse
    @participant = Participant.new
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
        #format.js   { }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
        format.js { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
      @participant.destroy


    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #lists ALL the deleted participants in order so that we can undo
  def undolist
    @participants = Participant.only_deleted.reverse
  end

  #controller to fully delete a participant
  def undo_deletion
    Participant.only_deleted.find(params[:id]).restore

    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully recovered.' }
      format.json { head :no_content }
    end
  end

  #controller to fully delete a participant
  def really_delete
    Participant.only_deleted.find(params[:id]).really_destroy!

    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def match_rank

    participants = Participant.all.reverse
    @names_with_ranks = {}

    participants.map do |participant|
      rank_participant = RankParticipant.find_by(name: participant.name, bib_number: participant.bib_number)
      rank = -1
      end_time = -1
      start_time = -1
      time_delta = -1

      unless rank_participant.nil?
        #if we have a participant with a rank, get the timing object to check end time
        rank = rank_participant.rank
        timing_object = Rank.find_by(rank: rank)

        unless timing_object.nil?
          #if we do have a timing object, get the end time
          end_time = timing_object.end_time
          #get a wave object to check for a start time
          wave_object = Wave.find_by(wave_number: participant.wave_number)

          unless wave_object.nil?
            start_time = wave_object.start_time

            #time delta is in MINUTES
            time_delta = (end_time - start_time).to_i / 60
          end

        end
      else
        rank = -1
      end

      #create final hash as key pointing to array of values
      @names_with_ranks[participant.name] = [rank, start_time, end_time, time_delta]

    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:name, :bib_number, :wave_number)
    end
end
