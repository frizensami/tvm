class RankParticipantsController < ApplicationController
  before_action :set_rank_participant, only: [:show, :edit, :update, :destroy]

  # GET /rank_participants
  # GET /rank_participants.json
  def index
    @rank_participants = RankParticipant.all.reverse
    @rank_participant = RankParticipant.new
  end

  # GET /rank_participants/1
  # GET /rank_participants/1.json
  def show
  end

  # GET /rank_participants/new
  def new
    @rank_participant = RankParticipant.new
  end

  # GET /rank_participants/1/edit
  def edit
  end

  # POST /rank_participants
  # POST /rank_participants.json
  def create
    @rank_participant = RankParticipant.new(rank_participant_params)

    respond_to do |format|
      if @rank_participant.save
        format.html { redirect_to @rank_participant, notice: 'Rank participant was successfully created.' }
        format.json { render :show, status: :created, location: @rank_participant }
      else
        format.html { render :new }
        format.json { render json: @rank_participant.errors, status: :unprocessable_entity }
        format.js { render json: @rank_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rank_participants/1
  # PATCH/PUT /rank_participants/1.json
  def update
    respond_to do |format|
      if @rank_participant.update(rank_participant_params)
        format.html { redirect_to @rank_participant, notice: 'Rank participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @rank_participant }
      else
        format.html { render :edit }
        format.json { render json: @rank_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rank_participants/1
  # DELETE /rank_participants/1.json
  def destroy
    @rank_participant.destroy
    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'Rank participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #lists ALL the deleted participants in order so that we can undo
  def undolist
    @rank_participants = RankParticipant.only_deleted.reverse
  end

  #controller to fully delete a participant
  def undo_deletion
    RankParticipant.only_deleted.find(params[:id]).restore

    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'RankParticipant was successfully recovered.' }
      format.json { head :no_content }
    end
  end

  #controller to fully delete a participant
  def really_delete
    RankParticipant.only_deleted.find(params[:id]).really_destroy!

    respond_to do |format|
      format.html { redirect_to rank_participants_url, notice: 'RankParticipant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rank_participant
      @rank_participant = RankParticipant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rank_participant_params
      params.require(:rank_participant).permit(:rank, :name, :bib_number)
    end
end
