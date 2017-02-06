require 'csv'
class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  # GET /participants.json
  def index
    #@participants = Participant.all
    @participants = Participant.order('wave_number ASC')
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

  def search_bib
    if params[:search]
      puts "Searching with param #{params[:search]}"
      @participant = Participant.where(bib_number: params[:search].upcase.strip).first
      unless @participant.present?
        flash[:notice] = "Participant could not be found!"
        redirect_to participants_path
      end
    else
      render plain: "No search parameter!"
    end
  end

  def by_wave
    @participants = Participant.where(wave_number: params[:wave_number])
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        #format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.html { redirect_to participants_path, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
        #format.js   { }
      else
        p @participant.errors
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
        #format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.html { redirect_to participants_path, notice: 'Participant was successfully updated.' }
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
    Time.zone = "Singapore"
=begin
    participants = Participant.all
    @names_with_ranks = {}

    participants.each do |participant|

      rp = RankParticipant.where(bib_number: participant.bib_number).first
      end_time = Rank.where(rank: rp.rank).first.end_time
      wave = Wave.where(wave_number: participant.try(:wave_number)).first

      rank = rp.rank
      start_time = wave.start_time

      time_delta = Time.at((end_time.to_f - start_time.to_f)).utc.strftime("%H:%M:%S.%3N")
      waveId = wave.wave_number


       @names_with_ranks[participant.name] = [rank, start_time.strftime("%d/%m/%Y %H:%M:%S.%3N"), end_time.strftime("%d/%m/%Y %H:%M:%S.%3N"), time_delta, wave_number]
    end
=end


    participants = Participant.order("wave_number ASC")
    @all_info = []

    participants.map do |participant|
      rank_participant = RankParticipant.find_by(bib_number: participant.bib_number)

      rank = nil
      wave_number = nil
      end_time = nil
      start_time = nil
      time_delta = nil

      #get a wave object to check for a start time
      wave_number = participant.wave_number

      unless wave_number.blank?
        start_time = Wave.find_by(wave_number: participant.wave_number).start_time

        unless rank_participant.nil?
          #if we have a participant with a rank, get the timing object to check end time
          rank = rank_participant.rank
          timing_object = Rank.find_by(rank: rank)

          unless timing_object.nil?
            #if we do have a timing object, get the end time
            end_time = timing_object.end_time
            #time delta is in MINUTES
            time_delta = Time.at((end_time.to_f - start_time.to_f)).utc.strftime("%H:%M:%S.%3N")
          end

        end
      end

      #create final hash as key pointing to array of values
      @all_info << {name: participant.name,
                    rank: rank,
                    start_time: start_time.try(:strftime, "%d/%m/%Y %H:%M:%S.%3N"),
                    end_time: end_time.try(:strftime, "%d/%m/%Y %H:%M:%S.%3N"),
                    timing: time_delta || DateTime.new, wave_number: wave_number
                  }

      CSV.open("data.csv", "wb") do |csv|
        @all_info.each do |hash|
          csv << hash.values
        end
      end
    end

    p "All info!!"
    p @all_info
  end


  def unfinished
    @participants = Participant.all
    @rank_participants = RankParticipant.all

    # Select from the list of participants, those that hasn't finished the race
    # @rank_participants.any checks for any rank_participant within the @rank_participants array and returns those whose bib_number is the
    # same as participant.bib_number
    # "!" chooses the participants whose bib number isn't registered in rank_participants' bib numbers
    @unfinished_participants = @participants.select { |x| !@rank_participants.any? {
        |rank_participant| rank_participant.bib_number == x.bib_number
      } }

    # Select from the list of rank_participants those that has finished the race and got a rank registered BUT are not registered at the start
    # @participants.any checks for an participant within the @participants array and returns those whose bib_number is the
    # same as rank_participant.bib_number
    # "!" chooses the rank_participants whose bib number isn't registered in participants' bib numbers
    @unregistered_rank_participants = @rank_participants.select { |x| !@participants.any? {
        |participant| participant.bib_number == x.bib_number
      } }

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
